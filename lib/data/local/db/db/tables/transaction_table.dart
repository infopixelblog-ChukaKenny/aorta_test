import 'package:drift/drift.dart';

enum TransactionStatus {
  pending,
  processing,
  completed,
  failed,
}

class Transactions extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  TextColumn get recipient => text()();
  IntColumn get errorCode => integer().nullable()();

  TextColumn get status => textEnum<TransactionStatus>()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get queuedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
