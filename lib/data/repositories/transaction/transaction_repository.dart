import 'dart:async';

import 'package:aorta/data/bankingservice/effective_balance.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class TransactionRepository {
  Future<Either<Exception, TransactionEntity>> sendTransaction({
    required String transactionId,
    required String fromAccount,
    required String toRecipient,
    required double amount,
    required String pin,
  });

  Future<Either<Exception, EffectiveBalance>> getBalance();

  Stream<EffectiveBalance> subscribeToBalance();

  Stream<List<TransactionEntity>> subscribeToTransactions();

  Future<void> syncPendingTransactions();

}
