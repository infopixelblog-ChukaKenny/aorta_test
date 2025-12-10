
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> listen(){
    return Stream.value(true);
  }
}

class NetworkInfoImpl extends NetworkInfo {
  InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker}) : super();

  Future<bool> checkInternet() async {
    return await internetConnectionChecker.hasConnection;
  }

  @override
  Stream<bool> listen(){
    return internetConnectionChecker.onStatusChange.map((re)=>re==InternetConnectionStatus.connected);
  }

  @override
  Future<bool> get isConnected async => checkInternet();
}
