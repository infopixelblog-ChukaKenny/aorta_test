
import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/data/local/db/database/aorta_database_manager.dart';
import 'package:aorta/data/local/db/database/aorta_database_manager_impl.dart';

Future<void> initDbInjections() async {
  sl.registerLazySingleton<AortaDatabaseService>(
    () => AortaDatabaseServiceImpl(),
  );
}
