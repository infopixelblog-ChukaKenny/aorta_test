import 'dart:developer';
import 'app_database.dart';

class DBProvider {
  static DBProvider? _instance;
  late AppDatabase _db;

  DBProvider._internal() {
    _initializeDatabase();
  }

  /// Singleton instance getter
  static DBProvider get instance {
    _instance ??= DBProvider._internal();
    return _instance!;
  }

  AppDatabase get database => _db;

  /// Initializes the database
  void _initializeDatabase() {
    _db = AppDatabase();
  }

  /// Properly closes the database
  Future<void> close() async {
    try {
      await _db.closeDb();
    } catch (e, st) {
      log("Error while closing Drift => $e $st");
    }
  }

  /// Resets the instance and ensures the next access creates a new one
  static Future<void> reset() async {
    try {
      if (_instance != null) {
        await _instance!.close(); // Close the current DB
        _instance = null; // Remove the instance
      }
    } catch (e, st) {
      log("HERE IS THE ERROR IN RESETTING DRIFT =>${e} ${st}");
    }
  }
}
