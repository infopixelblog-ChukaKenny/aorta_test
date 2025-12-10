import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/data/bankingservice/aorta_banking_service.dart';
import 'package:aorta/data/bankingservice/aorta_banking_service_impl.dart';
import 'package:aorta/data/local/db/db/app_database.dart';
import 'package:aorta/data/local/db/db/db_provider.dart';
import 'package:aorta/data/local/storage/local_storage.dart';
import 'package:aorta/data/local/storage/local_storage_impl.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository_impl.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

Future<void> initRepositoriesInjection() async {
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(bankingService: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<GetSecureStorage>(
    () => GetSecureStorage (container:"Aorta",password: "Aorta@124",
        initialData: {"server_balance":"510"}),
  );

  sl.registerLazySingleton<LocalStorage>(() => LocalSecureStorage(box: sl()));

  sl.registerLazySingleton<AppDatabase>(() => DBProvider.instance.database);

  sl.registerLazySingleton<BankingService>(
    () => AortaBankingServiceImpl(sl(), sl()),
  );
}
