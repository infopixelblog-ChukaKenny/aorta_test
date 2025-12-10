import 'package:flutter_test/flutter_test.dart';
import 'package:aorta/data/bankingservice/aorta_banking_service_impl.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure_code.dart';
import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:drift/native.dart';

import 'fakes/fake_local_storage.dart';

/// Helper to create an in-memory database
AppDatabase createTestDb() => AppDatabase(NativeDatabase.memory());

void main() {
  late FakeLocalStorage storage;
  late AppDatabase db;
  late AortaBankingServiceImpl service;

  setUp(() async {
    storage = FakeLocalStorage();
    db = createTestDb();
    await storage.saveString('server_balance', '100');
    service = AortaBankingServiceImpl(storage, db);
    await storage.saveString('server_balance', '100');
  });

  tearDown(() async {
    await service.dispose();
    await db.close();
  });

  test('initial effective balance', () async {
    final balance = await service.getCurrentEffectiveBalance();
    expect(balance.confirmed, 100);
    expect(balance.pending, 0);
    expect(balance.available, 100);
  });

  test('pending transaction reduces effective balance', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx1',
            amount: 30,
            recipient: 'alice',
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            status: TransactionStatus.pending,
          ),
        );
    print("Data stored");
    final balance = await service.getCurrentEffectiveBalance();
    expect(balance.pending, 30);
    expect(balance.available, 70);
  });

  test('canCover returns true when sufficient funds', () async {
    final result = await service.canCover(50);
    expect(result, true);
  });

  test('canCover returns false when insufficient funds', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx2',
            amount: 90,
            createdAt: DateTime.now(),
            recipient: 'bob',
            status: TransactionStatus.pending,
            queuedAt: DateTime.now(),
          ),
        );

    final result = await service.canCover(20);
    expect(result, false);
  });

  test('validatePendingTransaction fails for small amount', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-small',
            amount: 0.5,
            recipient: 'bob',
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            status: TransactionStatus.pending,
          ),
        );

    final result = await service.validatePendingTransaction('tx-small');
    expect(result.isLeft(), true);
    expect(
      result.getLeft().toNullable()?.code,
      BalanceFailureCode.amountTooSmall,
    );
  });

  test('validatePendingTransaction fails for insufficient funds', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-big',
            amount: 200,
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            recipient: 'bob',
            status: TransactionStatus.pending,
          ),
        );

    final result = await service.validatePendingTransaction('tx-big');
    expect(result.isLeft(), true);
    expect(
      result.getLeft().toNullable()?.code,
      BalanceFailureCode.insufficientFunds,
    );
  });

  test('completeTransaction reduces server balance', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-ok',
            amount: 40,
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            recipient: 'bob',
            status: TransactionStatus.processing,
          ),
        );

    await service.completeTransaction(txId: 'tx-ok');
    expect(storage.getString('server_balance'), '60.0');

    final tx = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals('tx-ok'))).getSingle();
    expect(tx.status, TransactionStatus.completed);
  });

  test('markTransactionPending sets status', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-state',
            amount: 10,
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            recipient: 'alice',
            status: TransactionStatus.processing,
          ),
        );

    await service.markTransactionPending('tx-state');
    final tx = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals('tx-state'))).getSingle();
    expect(tx.status, TransactionStatus.pending);
  });

  test('markTransactionProcessing sets status', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-state',
            amount: 10,
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            recipient: 'alice',
            status: TransactionStatus.pending,
          ),
        );

    await service.markTransactionProcessing('tx-state');
    final tx = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals('tx-state'))).getSingle();
    expect(tx.status, TransactionStatus.processing);
  });

  test('failed transaction restores available balance', () async {
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tx-fail',
            amount: 50,
            queuedAt: DateTime.now(),
            createdAt: DateTime.now(),
            recipient: 'alice',
            status: TransactionStatus.pending,
          ),
        );

    await service.failTransaction(
      txId: 'tx-fail',
      code: BalanceFailureCode.insufficientFunds,
    );

    final balance = await service.getCurrentEffectiveBalance();
    expect(balance.pending, 0);
    expect(balance.available, 100);
  });
}
