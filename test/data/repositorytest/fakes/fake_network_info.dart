import 'package:aorta/data/core/network_info.dart';

class FakeNetworkInfo implements NetworkInfo {
  bool connected;

  FakeNetworkInfo(this.connected);

  @override
  Future<bool> get isConnected async => connected;

  @override
  Stream<bool> listen() {
    return Stream.value(true);
  }
}
