

import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/features/transfer/presentation/bloc/send_money_bloc.dart';

Future<void> initializeTransferInjection() async {
  sl.registerLazySingleton(() => SendMoneyBloc(repository: sl(),networkInfo: sl()));

}
