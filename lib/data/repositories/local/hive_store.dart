import 'dart:developer';

import 'package:hive_flutter/adapters.dart';

import 'local_store.dart';

class HiveStore extends LocalStore {
  final String key;

  HiveStore(this.key);

  Box? _store;

  @override
  Future<void> clearAll() async {
    _store?.clear();
  }

  @override
  Future<void> delete(String key) async {
    // Clear all records from the store
    return await _store?.delete(key);
  }

  @override
  Future get(String key) async => await _store?.get(key);

  @override
  Future<void> init() async => _store ??= await Hive.openBox(key);

  @override
  Future<void> set<T>(String key, T value) async {
    try {
      await _store?.put(key, value);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
