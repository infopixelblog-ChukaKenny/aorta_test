import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';

abstract class AortaDatabaseService {
  late AppDatabase db;

  Stream<List<R>> watchItems<T extends HasResultSet, R>(
      ResultSetImplementation<T, R> table,
      {Function(SimpleSelectStatement<T, R>)? operator});
  Stream<R?> watchItem<T extends HasResultSet, R>(
      ResultSetImplementation<T, R> table,
      {Function(SimpleSelectStatement<T, R>)? operator});

  Future<List<D>> getItems<T extends Table, D>(TableInfo<T, D> table,
      {Function(SimpleSelectStatement<T, D>)? operator});

  Future<D?> getItemById<T extends Table, D>(
      TableInfo<T, D> table, Expression<bool> Function(T) filter,
      {List<OrderClauseGenerator<T>>? orderBy});

  Future<List<D>> getItemsFiltering<T extends Table, D>(
      TableInfo<T, D> table, Expression<bool> Function(T) filter,
      {Function(SimpleSelectStatement<T, D>)? orderBy});

  Future<int> insertItem<T extends Table, D>(
      TableInfo<T, D> table, Insertable<D> entity);
  Future<void> insertItems<T extends Table, D>(
      TableInfo<T, D> table, List<Insertable<D>> entities);

  Future<bool> updateItem<T extends Table, D>(
      TableInfo<T, D> table, Insertable<D> entity);

  Future<int> deleteItem<T extends Table, D extends DataClass>(
      TableInfo<T, D> table, Expression<bool> Function(T) filter);

  static AortaDatabaseService getInstance() {
    return GetIt.instance<AortaDatabaseService>();
  }
}
