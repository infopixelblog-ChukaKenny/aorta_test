import 'package:aorta/data/local/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

class LocalSecureStorage implements LocalStorage {
  final GetSecureStorage box;

  LocalSecureStorage({required this.box}){
    debugPrint(box.read("server_balance"));
    if(!box.hasData("server_balance")){
      debugPrint("No data");
      box.write("server_balance", "700");
      debugPrint(box.read("server_balance"));
    }
  }

  @override
  Future<void> saveString(String key, String value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  Future<void> saveInt(String key, int value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  Future<void> saveList(String key, List<dynamic> value) async {
    box.write(key, value);
    await box.save();
  }

  @override
  String? getString(String key) => box.read(key) as String?;

  @override
  bool? getBool(String key) => box.read(key) as bool?;

  @override
  int? getInt(String key) => box.read(key) as int?;

  @override
  double? getDouble(String key) => box.read(key) as double?;

  @override
  Map<String, dynamic>? getMap(String key) =>
      box.read(key) as Map<String, dynamic>?;

  @override
  List<dynamic>? getList(String key) => box.read(key) as List<dynamic>?;

  @override
  Future<void> remove(String key) async {
    box.remove(key);
    await box.save();
  }

  @override
  Future<void> clear() async {
    box.erase();
  }

  @override
  void clearListeners() {
    for (var listener in listeners) {
      listener.call();
    }
  }

  List<Function> listeners = [];

  @override
  void listen(
    String key,
    Function(Function value) disposeCallBack,
    Function(dynamic value) onChange,
  ) {
    if(box.hasData(key)) {
        final listener = box.listenKey(key, (value) {
          onChange(value);
        });
        listeners = [...listeners, listener];
        disposeCallBack(listener);

    }
  }
}
