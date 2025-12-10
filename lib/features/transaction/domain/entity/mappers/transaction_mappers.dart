import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:drift/drift.dart';

extension TransactionRowMapper on Transaction {
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      amount: amount,
      recipient: recipient,
      status: status,
      createdAt: createdAt,
      queuedAt: queuedAt,
      errorCode: errorCode,
      retryCount: retryCount,
    );
  }
}

extension TransactionEntityMapper on TransactionEntity {
  TransactionsCompanion toCompanion() {
    return TransactionsCompanion.insert(
      id: id,
      amount: amount,
      recipient: recipient,
      status: status,
      createdAt: createdAt,
      queuedAt: queuedAt,
      retryCount: Value(retryCount),
      errorCode: Value.absentIfNull(errorCode),
    );
  }
}
