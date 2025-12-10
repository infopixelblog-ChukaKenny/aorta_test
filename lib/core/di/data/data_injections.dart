
import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/data/core/Network_call.dart';
import 'package:aorta/data/core/aorta_network_call.dart';
import 'package:aorta/data/core/interceptors/logging_interceptor.dart' show LoggerInterceptor;
import 'package:aorta/data/core/network_info.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> initDataInjections() async {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: sl()),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 2), // Custom check timeout
      checkInterval: const Duration(seconds: 1), // Custom check interval
    ),
  );

  sl.registerLazySingleton<Interceptor>(() => LoggerInterceptor());

  sl.registerLazySingleton<Dio>(() => Dio()..interceptors.addAll([sl()]));

  sl.registerLazySingleton<AortaNetworkcall>(
    () => NetworkCall(dio: sl(), networkInfo: sl()),
  );
}
