import 'dart:developer';
import 'dart:io';
import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

part 'app_database.g.dart';

Future<String> fetchDatabasePath(String dbName) async {
  if (Platform.isIOS) {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, dbName);
  } else {
    final dir = await getDatabasesPath();
    return p.join(dir, dbName);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final profile = "user";

    final dbPath = await fetchDatabasePath(
      'app_${profile}_file${kDebugMode ? "Debug" : ""}.db',
    );
    final dbFile = File(dbPath);

    return NativeDatabase.createInBackground(
      dbFile,
      setup: (db) async {
        db.execute("PRAGMA journal_mode=WAL;"); // Enable WAL mode
        db.execute("PRAGMA busy_timeout = 5000;"); // 5s wait if locked
      },
    );
  });
}

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([NativeDatabase? nativeDatabase])
    : super(nativeDatabase ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // Create all tables on a fresh database
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      log("CALLED ON UPGRADE from $from to $to");

      // future migrations go here…
    },
  );

  Future<bool> columnExists(
    DatabaseConnectionUser db,
    String table,
    String column,
  ) async {
    final result = await db.customSelect('PRAGMA table_info($table);').get();
    return result.any((row) => row.data['name'] == column);
  }

  /// Close the DB when you’re done.
  Future<void> closeDb() async {
    await close();
  }

  /// (Re)open the DB if needed.
  Future<void> openDb() async {
    _openConnection();
  }
}
