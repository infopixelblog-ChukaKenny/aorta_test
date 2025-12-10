import 'dart:async';

import 'package:aorta/data/bankingservice/aorta_banking_service.dart';
import 'package:aorta/data/bankingservice/aorta_banking_service_impl.dart';
import 'package:aorta/data/bankingservice/effective_balance.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure_code.dart';
import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:fpdart/fpdart.dart';

class FakeBankingService implements BankingService {
  final Map<String, TransactionEntity> store = {};

  EffectiveBalance _balance = const EffectiveBalance(
    confirmed: 1000,
    pending: 0,
  );

  final _serverBalanceController = StreamController<double>.broadcast();

  final _effectiveBalanceController =
      StreamController<EffectiveBalance>.broadcast();

  FakeBankingService() {
    _serverBalanceController.add(_balance.confirmed);
    _emitBalance();
  }

  // ---------------- BALANCE ----------------

  void _emitBalance() {
    _effectiveBalanceController.add(_balance);
  }

  void _recalculatePending() {
    final pending = store.values
        .where(
          (e) =>
              e.status == TransactionStatus.pending ||
              e.status == TransactionStatus.processing,
        )
        .fold<double>(0, (s, e) => s + e.amount);

    _balance = _balance.copyWith(pending: pending);
    _emitBalance();
  }

  @override
  Stream<EffectiveBalance> get effectiveBalanceStream =>
      _effectiveBalanceController.stream;

  @override
  Stream<double> get serverBalanceStream =>
      _serverBalanceController.stream.distinct();

  @override
  Future<double> getCurrentServerBalance() => Future.value(_balance.confirmed);

  @override
  Future<EffectiveBalance> getCurrentEffectiveBalance() async => _balance;

  @override
  Future<void> updateServerBalance(double newBalance) async {
    _balance = _balance.copyWith(confirmed: newBalance);
    _serverBalanceController.add(newBalance);
    _emitBalance();
  }

  @override
  Future<double> getPendingTransactionsSum({String? excludeTxId}) async {
    return store.values
        .where(
          (tx) =>
              (tx.status == TransactionStatus.pending ||
                  tx.status == TransactionStatus.processing) &&
              (excludeTxId == null || tx.id != excludeTxId),
        )
        .fold(0.0, (s, tx) async => await s + tx.amount);
  }

  @override
  Future<bool> canCover(double amount, {String? excludeTxId}) async {
    final pending = await getPendingTransactionsSum(excludeTxId: excludeTxId);
    return (_balance.confirmed - pending) >= amount;
  }

  // ---------------- TRANSACTIONS ----------------

  @override
  Future<void> save(TransactionEntity tx) async {
    store[tx.id] = tx;
    _recalculatePending();
  }

  @override
  Future<Either<BalanceFailure?, Unit>> validatePendingTransaction(
      String txId,
      ) async {
    final tx = store[txId];
    if (tx == null) return Left(null);

    if (tx.amount < AortaBankingServiceImpl.minTransactionAmount) {
      await failTransaction(
        txId: txId,
        code: BalanceFailureCode.amountTooSmall,
      );

      return Left(
        BalanceFailure.amountTooSmall(
          min: AortaBankingServiceImpl.minTransactionAmount,
          requested: tx.amount,
        ),
      );
    }

    final pendingExcludingTx = await getPendingTransactionsSum(
      excludeTxId: txId,
    );

    final available = _balance.confirmed - pendingExcludingTx;

    if (available < tx.amount) {
      await failTransaction(
        txId: txId,
        code: BalanceFailureCode.insufficientFunds,
      );

      return Left(
        BalanceFailure.insufficientFunds(
          available: available,
          requested: tx.amount,
        ),
      );
    }

    return Right(unit);
  }


  @override
  Future<void> markTransactionPending(String txId) async {
    final tx = store[txId];
    if (tx != null) {
      store[txId] = tx.copyWith(status: TransactionStatus.pending);
      _recalculatePending();
    }
  }

  @override
  Future<void> markTransactionProcessing(String txId) async {
    final tx = store[txId];
    if (tx != null) {
      store[txId] = tx.copyWith(status: TransactionStatus.processing);
      _recalculatePending();
    }
  }

  @override
  Future<TransactionEntity?> completeTransaction({required String txId}) async {
    final tx = store[txId];
    if (tx == null) return null;

    store[txId] = tx.copyWith(status: TransactionStatus.completed);
    _balance = _balance.copyWith(confirmed: _balance.confirmed - tx.amount);

    _serverBalanceController.add(_balance.confirmed);
    _recalculatePending();
    return store[txId];
  }

  @override
  Future<void> failTransaction({
    required String txId,
    required BalanceFailureCode code,
  }) async {
    final tx = store[txId];
    if (tx != null) {
      store[txId] = tx.copyWith(
        status: TransactionStatus.failed,
        errorCode: code.numeric,
      );
      _recalculatePending();
    }
  }

  @override
  Future<List<TransactionEntity>> getPendingTransactions() async {
    return store.values
        .where((e) => e.status == TransactionStatus.pending)
        .toList()
      ..sort((a, b) => a.queuedAt.compareTo(b.queuedAt));
  }

  @override
  Stream<List<TransactionEntity>> watchAllTransactions() =>
      Stream.value(store.values.toList());

  @override
  Future<void> dispose() async {
    await _serverBalanceController.close();
    await _effectiveBalanceController.close();
  }
}
