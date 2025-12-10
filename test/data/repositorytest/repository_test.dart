import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository_impl.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fakes/fake_banking_service.dart';
import 'fakes/fake_network_info.dart';

void main() {
  late FakeBankingService banking;
  late FakeNetworkInfo network;
  late TransactionRepository repo;

  setUp(() {
    banking = FakeBankingService();
    network = FakeNetworkInfo(true);
    repo = TransactionRepositoryImpl(
      bankingService: banking,
      networkInfo: network,
      shouldSimulate: false
    );
  });

  test('sendTransaction succeeds when online', () async {
    final res = await repo.sendTransaction(
      transactionId: 'tx1',
      fromAccount: 'wallet',
      toRecipient: 'bob',
      amount: 100,
      pin: '1234',
    );

    expect(res.isRight(), true);
    expect(banking.store['tx1']?.status, TransactionStatus.completed);
  });

  test('sendTransaction fails when insufficient funds', () async {
    banking.updateServerBalance(50);

    final res = await repo.sendTransaction(
      transactionId: 'tx2',
      fromAccount: 'wallet',
      toRecipient: 'bob',
      amount: 100,
      pin: '1234',
    );

    expect(res.isLeft(), true);
    expect(
      banking.store['tx2']?.status,
      TransactionStatus.failed,
    );
  });

  test('sendTransaction fails when offline', () async {
    network.connected = false;

    final res = await repo.sendTransaction(
      transactionId: 'tx3',
      fromAccount: 'wallet',
      toRecipient: 'bob',
      amount: 10,
      pin: '1234',
    );

    expect(res.isLeft(), true);
  });

  test('syncPendingTransactions retries all pending', () async {
    // create pending tx
    await banking.save(TransactionEntity.create(
      id: 'tx4',
      amount: 20,
      recipient: 'alice',
    ));

    await repo.syncPendingTransactions();

    await Future.delayed(const Duration(milliseconds: 50));

    print(banking.store['tx4']);

    expect(
      banking.store['tx4']?.status,
      TransactionStatus.completed,
    );
  });
}
