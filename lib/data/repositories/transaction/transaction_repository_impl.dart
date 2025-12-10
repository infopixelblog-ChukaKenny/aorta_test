import 'dart:async';
import 'dart:math';

import 'package:aorta/data/bankingservice/aorta_banking_service.dart';
import 'package:aorta/data/bankingservice/effective_balance.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure.dart';
import 'package:aorta/data/bankingservice/utils/balance_failure_code.dart';
import 'package:aorta/data/core/error/exceptions.dart';
import 'package:aorta/data/core/network_info.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/utils/utils.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final BankingService bankingService;
  final NetworkInfo networkInfo;
  final bool shouldSimulate;

  bool? _lastResult;

  TransactionRepositoryImpl({
    required this.bankingService,
    required this.networkInfo,
    this.shouldSimulate = true,
  });

  /// Simulates an API call that may succeed or fail.
  /// Returns true on success, false on failure.
  ///
  @override
  Future<Either<Exception, TransactionEntity>> sendTransaction({
    required String transactionId,
    required String fromAccount,
    required String toRecipient,
    required double amount,
    required String pin,
  }) async {
    final tx = TransactionEntity.create(
      id: transactionId,
      amount: amount,
      recipient: toRecipient,
    );

    await bankingService.save(tx);
    return await _processTrx(transactionId: transactionId);
  }

  Future<Either<Exception, TransactionEntity>> _processTrx({
    required String transactionId,
  }) async {
    if (await networkInfo.isConnected) {
      final validation = await bankingService.validatePendingTransaction(
        transactionId,
      );

      if (validation.isLeft()) {
        final error = validation.getLeft().toNullable();
        if (error != null) {
          return Left(
            TransactionException(
              message: error.message ?? UNKNOWN_ERROR_STRING,
              errorCode: error.code.index,
            ),
          );
        }
        final failure = BalanceFailure.unknown(UNKNOWN_ERROR_STRING);
        return Left(
          TransactionException(
            message: failure.message ?? "",
            errorCode: failure.code.index,
          ),
        );
      }

      await bankingService.markTransactionProcessing(transactionId);

      // Simulate network latency
      await Future.delayed(const Duration(seconds: 2));

      // Simulated API result (deterministic for testing)
      final success = shouldSimulate
          ? _lastResult == null
                ? Random().nextBool()
                : !_lastResult!
          : true;
      _lastResult = success;

      if (success) {
        final completedTransaction = await bankingService.completeTransaction(
          txId: transactionId,
        );
        if (completedTransaction != null) {
          return Right(completedTransaction);
        } else {
          final failure = BalanceFailure.unknown(UNKNOWN_ERROR_STRING);
          return Left(
            TransactionException(
              message: failure.message ?? "",
              errorCode: failure.code.index,
            ),
          );
        }
      } else {
        final failure = BalanceFailure.serverError();
        await bankingService.failTransaction(
          txId: transactionId,
          code: failure.code,
        );
        return Left(
          TransactionException(
            message: failure.message ?? UNKNOWN_ERROR_STRING,
            errorCode: failure.code.index,
          ),
        );
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, EffectiveBalance>> getBalance() async {
    return Right(await bankingService.getCurrentEffectiveBalance());
  }

  @override
  Stream<EffectiveBalance> subscribeToBalance() {
    return bankingService.effectiveBalanceStream;
  }

  @override
  Stream<List<TransactionEntity>> subscribeToTransactions() {
    return bankingService.watchAllTransactions();
  }

  var _syncing = false;

  @override
  Future<void> syncPendingTransactions() async {
    if (!_syncing) {
      _syncing = true;
      final pending = await bankingService.getPendingTransactions();
      for (var trx in pending) {
        await _processTrx(transactionId: trx.id);
      }
      _syncing = false;
    }
  }
}
