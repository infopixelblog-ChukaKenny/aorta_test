import 'package:aorta/core/di/data/data_injections.dart';
import 'package:aorta/data/repositories/di/repository_injections.dart';
import 'package:aorta/features/transaction/di/transaction_injections.dart';
import 'package:aorta/features/transfer/di/transfer_injections.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

import 'bloc/bloc_injections.dart';

Future<void> initInjections() async {
  await GetSecureStorage.init(container: "Aorta", password: 'Aorta@124');
  await Future.wait([
    initializeBlocInjections(),
    initDataInjections(),
    initRepositoriesInjection(),
    initializeTransferInjection(),
    initializeTransactionInjection(),
  ]);
}
