

import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:aorta/features/transfer/presentation/bloc/send_money_bloc.dart';

Future<void> initializeTransactionInjection() async {
  sl.registerLazySingleton(() => TransactionHistoryBloc(repository: sl()));

}
