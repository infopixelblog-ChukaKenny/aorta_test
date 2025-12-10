part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class TransactionHistoryInit extends TransactionEvent {
  @override
  List<Object?> get props => [];
}

class TransactionHistoryUpdated extends TransactionEvent {
  final List<TransactionEntity> transactions;

  const TransactionHistoryUpdated(this.transactions);

  @override
  List<Object?> get props => [transactions];
}