import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:equatable/equatable.dart';


class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String recipient;
  final int? errorCode;
  final TransactionStatus status;
  final DateTime createdAt;
  final DateTime queuedAt;
  final int retryCount;

  const TransactionEntity({
    required this.id,
    required this.amount,
    this.errorCode,
    required this.recipient,
    required this.status,
    required this.createdAt,
    required this.queuedAt,
    required this.retryCount,
  });

  TransactionEntity copyWith({
    TransactionStatus? status,
    int? retryCount,
    int? errorCode,
  }) {
    return TransactionEntity(
      id: id,
      amount: amount,
      recipient: recipient,
      status: status ?? this.status,
      createdAt: createdAt,
      queuedAt: queuedAt,
      errorCode: errorCode??this.errorCode,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  factory TransactionEntity.create({
    required String id,
    required double amount,
    required String recipient,
  }) {
    final now = DateTime.now();

    return TransactionEntity(
      id: id,
      amount: amount,
      recipient: recipient,
      status: TransactionStatus.pending,
      createdAt: now,
      queuedAt: now,
      retryCount: 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, amount, recipient, status, createdAt, queuedAt, errorCode, retryCount,];
}
