import 'package:aorta/data/local/db/database/aorta_database_manager.dart';
import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:aorta/data/local/db/db/db_provider.dart';
import 'package:drift/drift.dart';

class AortaDatabaseServiceImpl extends AortaDatabaseService {
  @override
  AppDatabase get db => DBProvider.instance.database;

  AortaDatabaseServiceImpl();

  @override
  Future<List<D>> getItems<T extends Table, D>(
    TableInfo<T, D> table, {
    Function(SimpleSelectStatement<T, D>)? operator,
  }) {
    final query = db.select(table);
    if (operator != null) {
      operator(query);
    }
    return query.get();
  }

  @override
  Future<D?> getItemById<T extends Table, D>(
    TableInfo<T, D> table,
    Expression<bool> Function(T) filter, {
    List<OrderClauseGenerator<T>>? orderBy,
  }) {
    final query = db.select(table)..where(filter);
    if (orderBy != null) {
      query.orderBy(orderBy);
    }
    return query.getSingleOrNull();
  }

  @override
  Future<List<D>> getItemsFiltering<T extends Table, D>(
    TableInfo<T, D> table,
    Expression<bool> Function(T) filter, {
    Function(SimpleSelectStatement<T, D>)? orderBy,
  }) {
    final query = db.select(table)..where(filter);

    if (orderBy != null) {
      orderBy.call(query);
    }
    return query.get();
  }

  @override
  Future<int> insertItem<T extends Table, D>(
    TableInfo<T, D> table,
    Insertable<D> entity,
  ) {
    return db.into(table).insert(entity);
  }

  @override
  Future<bool> updateItem<T extends Table, D>(
    TableInfo<T, D> table,
    Insertable<D> entity,
  ) async {
    return (await db.update(table).replace(entity));
  }

  @override
  Future<int> deleteItem<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    Expression<bool> Function(T) filter,
  ) {
    return (db.delete(table)..where(filter)).go();
  }

  @override
  Stream<List<R>> watchItems<T extends HasResultSet, R>(
    ResultSetImplementation<T, R> table, {
    Function(SimpleSelectStatement<T, R>)? operator,
  }) {
    final query = db.select(table);

    if (operator != null) {
      operator(query);
    }

    return query.watch();
  }

  @override
  Stream<R?> watchItem<T extends HasResultSet, R>(
    ResultSetImplementation<T, R> table, {
    Function(SimpleSelectStatement<T, R>)? operator,
  }) {
    final query = db.select(table)..limit(1);

    if (operator != null) {
      operator(query);
    }

    return query.watchSingleOrNull();
  }

  @override
  Future<void> insertItems<T extends Table, D>(
    TableInfo<T, D> table,
    List<Insertable<D>> entities,
  ) async {
    return await db.batch((batch) {
      // functions in a batch don't have to be awaited - just
      // await the whole batch afterwards.
      batch.insertAll(table, entities, mode: InsertMode.insertOrIgnore);
    });
  }
}
