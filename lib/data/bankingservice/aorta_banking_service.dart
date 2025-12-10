import 'dart:async';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:fpdart/fpdart.dart';

import 'effective_balance.dart';
import 'utils/balance_failure.dart';
import 'utils/balance_failure_code.dart';

abstract class BankingService {
  /// Stream of the user-facing balance:
  /// confirmed (server) - pending (local drift)
  Stream<EffectiveBalance> get effectiveBalanceStream;

  /// Raw confirmed server balance stream
  Stream<double> get serverBalanceStream;

  /// Synchronous snapshot (use sparingly)
  Future<double> getCurrentServerBalance();

  /// Recalculate and persist server balance
  /// Called ONLY after successful API settlement
  Future<void> updateServerBalance(double newBalance);

  /// Sum of all pending + processing transactions
  Future<double> getPendingTransactionsSum({String? excludeTxId});
  ///  all pending transactions
  Future<List<TransactionEntity>> getPendingTransactions();

  /// Check if an amount can be covered at this instant
  Future<bool> canCover(double amount, {String? excludeTxId});

  /// Validate an already-created pending transaction.
  ///
  /// - Marks transaction as failed if invalid
  /// - Returns failure reason if blocked
  ///
  /// Left  → BalanceFailure
  /// Right → success
  Future<Either<BalanceFailure?, Unit>> validatePendingTransaction(String txId);

  /// Mark a transaction as failed
  Future<void> failTransaction({
    required String txId,
    required BalanceFailureCode code,
  });

  /// Complete a transaction:
  /// - Deducts from server balance
  /// - Marks transaction as completed
  Future<TransactionEntity?> completeTransaction({
    required String txId,
  });

  /// Explicit state transitions (workflow control)
  Future<void> markTransactionPending(String txId);
  Future<void> markTransactionProcessing(String txId);

  /// Cleanup resources
  Future<void> dispose();

  // get current effective balance
  Future<EffectiveBalance> getCurrentEffectiveBalance();

  Stream<List<TransactionEntity>> watchAllTransactions();

  Future<void> save(TransactionEntity transactioin);


}
