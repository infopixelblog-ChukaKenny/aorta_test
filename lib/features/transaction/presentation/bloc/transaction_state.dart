part of 'transaction_bloc.dart';

class TransactionHistoryState {
  final List<TransactionEntity> transactions;
  final String? errorMessage;

  const TransactionHistoryState({
    required this.transactions,
    this.errorMessage,
  });

  factory TransactionHistoryState.initial() {
    return const TransactionHistoryState(
      transactions: [],
    );
  }

  TransactionHistoryState copyWith({
    List<TransactionEntity>? transactions,
    String? errorMessage,
  }) {
    return TransactionHistoryState(
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
    );
  }
}
