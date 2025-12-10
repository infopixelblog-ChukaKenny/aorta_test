import 'dart:async';
import 'package:aorta/data/bankingservice/aorta_banking_service.dart';
import 'package:aorta/data/bankingservice/effective_balance.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure_code.dart';
import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:aorta/data/local/storage/local_storage.dart';
import 'package:aorta/features/transaction/domain/entity/mappers/transaction_mappers.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';

class AortaBankingServiceImpl extends BankingService {
  static const _serverBalanceKey = 'server_balance';

  final LocalStorage _storage;
  final AppDatabase _db;

  AortaBankingServiceImpl(this._storage, this._db) {
    initServerBalanceStream();
  }

  static const double minTransactionAmount = 1.0;

 
  late final Function _cancelServerBalanceListener;

  final _serverBalanceController = StreamController<double>.broadcast();

  late final _serverBalanceSubject = BehaviorSubject<double>.seeded(_getServerBalance());

  @override
  Stream<double> get serverBalanceStream =>
      _serverBalanceSubject.stream.distinct();

  
  // initializes the balance stream
  void initServerBalanceStream() async{
    _serverBalanceController.add(await _getServerBalance());

    _storage.listen(
      _serverBalanceKey,
      (listener) {
        _cancelServerBalanceListener = listener;
      },
      (value) {
        final balance = double.tryParse(value ?? '0') ?? 0.0;
        _serverBalanceSubject.add(balance);
      },
    );
  }

  // get actual balance: deducted pending from server balance
  @override
  Stream<EffectiveBalance> get effectiveBalanceStream {
    serverBalanceStream.listen((v) {
      print('SERVER EMIT => $v');
    });

    watchPendingTotal().listen((v) {
      print('PENDING EMIT => $v');
    });
    final pendingStream = watchPendingTotal().startWith(0.0);

    return Rx.combineLatest2<double, double, EffectiveBalance>(
      serverBalanceStream,
      pendingStream,
      (server, pending) {
        print("server is ${server} and Pending transactions is ${pending}");

        return EffectiveBalance(confirmed: server, pending: pending);
      },
    );
  }

  Stream<double> watchPendingTotal() {
    return (_db.select(_db.transactions)
      ..where((t) => t.status.isIn([
        TransactionStatus.pending.name,
        TransactionStatus.processing.name,
      ])))
        .watch()
        .map(
          (rows) => rows.fold<double>(
        0.0,
            (sum, row) => sum + row.amount,
      ),
    );
  }

  /// Helper to get current server balance synchronously
  double _getServerBalance() {
    String? value = _storage.getString(_serverBalanceKey);
    return double.tryParse(value.toString()) ?? 0.0;
  }

  /// Update Server Balance (Called only after successful API 200 OK)
  @override
  Future<void> updateServerBalance(double newBalance) async {
    await _storage.saveString(_serverBalanceKey, newBalance.toString());
    _serverBalanceSubject.add(newBalance);
  }

  @override
  Future<double> getPendingTransactionsSum({String? excludeTxId}) async {
    final query = _db.selectOnly(_db.transactions)
      ..addColumns([_db.transactions.amount.sum()])
      ..where(
        _db.transactions.status.isIn([
          TransactionStatus.pending.name,
          TransactionStatus.processing.name,
        ]),
      );

    if (excludeTxId != null) {
      query.where(_db.transactions.id.isNotValue(excludeTxId));
    }

    final result = await query.getSingle();
    return result.read(_db.transactions.amount.sum()) ?? 0.0;
  }

  @override
  Future<List<TransactionEntity>> getPendingTransactions() async {
    final rows =
        await (_db.select(_db.transactions)
              ..where((t) => t.status.equals(TransactionStatus.pending.name))
              ..orderBy([(t) => OrderingTerm.asc(t.queuedAt)]))
            .get();

    return rows.map((trx) => trx.toEntity()).toList();
  }

  /// ANTI-FRAUD CHECK
  /// Called BEFORE creating a transaction in Drift.
  /// Ensure we don't queue more than we have.
  @override
  Future<bool> canCover(double amount, {String? excludeTxId}) async {
    final currentServer = await _getServerBalance();

    final currentPending = await getPendingTransactionsSum(
      excludeTxId: excludeTxId,
    );

    final available = currentServer - currentPending;
    return available >= amount;
  }

  @override
  Future<Either<BalanceFailure?, Unit>> validatePendingTransaction(
    String txId,
  ) async {
    final tx = await (_db.select(
      _db.transactions,
    )..where((t) => t.id.equals(txId))).getSingleOrNull();

    if (tx == null) return Either.left(null);

    if (tx.amount < minTransactionAmount) {
      await _fail(txId, BalanceFailureCode.amountTooSmall);
      return Left(
        BalanceFailure.amountTooSmall(
          min: minTransactionAmount,
          requested: tx.amount,
        ),
      );
    }

    if (!await canCover(tx.amount, excludeTxId: txId)) {
      final server = await _getServerBalance();
      final currentPending = await getPendingTransactionsSum(excludeTxId: txId);
      await _fail(txId, BalanceFailureCode.insufficientFunds);
      return Left(
        BalanceFailure.insufficientFunds(
          available: server - currentPending,
          requested: tx.amount,
        ),
      );
    }

    return Either.right(unit);
  }

  @override
  Future<void> failTransaction({
    required String txId,
    required BalanceFailureCode code,
  }) async => _fail(txId, code);

  Future<void> _fail(String txId, BalanceFailureCode code) async {
    await (_db.update(_db.transactions)..where((t) => t.id.equals(txId))).write(
      TransactionsCompanion(
        status: Value(TransactionStatus.failed),
        errorCode: Value(code.numeric),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<TransactionEntity?> completeTransaction({required String txId}) async {
    await _db.transaction(() async {
      final tx = await (_db.select(
        _db.transactions,
      )..where((t) => t.id.equals(txId))).getSingleOrNull();

      if (tx == null) return;

      if (tx.status == TransactionStatus.completed) return;

      final currentServer =  _getServerBalance();
      final newServerBalance = currentServer - tx.amount;

      final safeBalance = newServerBalance < 0 ? 0.0 : newServerBalance;

      await updateServerBalance(safeBalance);
      await (_db.update(
        _db.transactions,
      )..where((t) => t.id.equals(txId))).write(
        TransactionsCompanion(
          status: Value(TransactionStatus.completed),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
    final updateTx = await (_db.select(
      _db.transactions,
    )..where((t) => t.id.equals(txId))).getSingleOrNull();
    return updateTx?.toEntity();
  }

  @override
  Future<void> markTransactionPending(String txId) async {
    await (_db.update(_db.transactions)..where((t) => t.id.equals(txId))).write(
      TransactionsCompanion(
        status: Value(TransactionStatus.pending),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> markTransactionProcessing(String txId) async {
    await (_db.update(_db.transactions)..where((t) => t.id.equals(txId))).write(
      TransactionsCompanion(
        status: Value(TransactionStatus.processing),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    _cancelServerBalanceListener.call();
    await _serverBalanceController.close();
  }

  @override
  Future<double> getCurrentServerBalance() {
    return Future.value(_getServerBalance());
  }

  @override
  Future<EffectiveBalance> getCurrentEffectiveBalance() async {
    final serverBalance = await _getServerBalance();
    final pendingBalance = await getPendingTransactionsSum();
    return EffectiveBalance(confirmed: serverBalance, pending: pendingBalance);
  }

  @override
  Stream<List<TransactionEntity>> watchAllTransactions() {
    return (_db.select(_db.transactions)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch()
        .map((rows) => rows.map((trx) => trx.toEntity()).toList());
  }

  @override
  Future<void> save(TransactionEntity transaction) async {
    await _db.into(_db.transactions).insert(transaction.toCompanion());
  }
}
