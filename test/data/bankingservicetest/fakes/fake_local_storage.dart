import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

import 'package:aorta/data/local/storage/local_storage.dart';

/// A simple in-memory fake for LocalStorage
class FakeLocalStorage implements LocalStorage {
  final Map<String, String> _map = {};
  final Map<String, List<void Function(String?)>> _listeners = {};

  @override
  String? getString(String key) => _map[key];

  @override
  Future<void> saveString(String key, String value) async {
    _map[key] = value;
    for (final cb in _listeners[key] ?? []) {
      cb(value);
    }
  }

  @override
  void listen(String key, Function(Function dispose) setDispose, Function(dynamic) onChange) {
    final list = _listeners.putIfAbsent(key, () => []);
    list.add(onChange as void Function(String?));
    setDispose(() {
      list.remove(onChange);
    });
  }

  @override
  Future<void> clear() async {
    _map.clear();
    _listeners.clear();
  }

  @override
  Future<void> saveBool(String key, bool value) async {}
  @override
  Future<void> saveDouble(String key, double value) async {}
  @override
  Future<void> saveInt(String key, int value) async {}
  @override
  Future<void> saveList(String key, List<dynamic> value) async {}
  @override
  Future<void> saveMap(String key, Map<String, dynamic> value) async {}
  @override
  bool? getBool(String key) => null;
  @override
  double? getDouble(String key) => null;
  @override
  int? getInt(String key) => null;
  @override
  List<dynamic>? getList(String key) => null;
  @override
  Map<String, dynamic>? getMap(String key) => null;
  @override
  Future<void> remove(String key) async {}
  @override
  void clearListeners() {}
}
