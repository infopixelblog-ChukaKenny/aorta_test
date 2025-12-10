abstract class LocalStorage {
  Future<void> saveString(String key, String value);
  Future<void> saveBool(String key, bool value);
  Future<void> saveInt(String key, int value);
  Future<void> saveDouble(String key, double value);
  Future<void> saveMap(String key, Map<String, dynamic> value);
  Future<void> saveList(String key, List<dynamic> value);

  String? getString(String key);
  bool? getBool(String key);
  int? getInt(String key);
  double? getDouble(String key);
  Map<String, dynamic>? getMap(String key);
  List<dynamic>? getList(String key);

  Future<void> remove(String key);
  void listen(String key, Function(Function value) disposeCallBack, Function(dynamic) onChange);
  void clearListeners();

  Future<void> clear();
}
