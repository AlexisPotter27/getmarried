import 'dart:developer';

import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/data/repositories/local/hive_store.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/models/user.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final store = HiveStore(StorageKeys.user);

  ProfileRepositoryImpl() {
    init();
  }

  @override
  Future<void> cacheUser(UserData profile) async {
    await store.set(StorageKeys.user, profile.toJson());
    log('USER ID${profile.uid.toString()}');
  }

  @override
  Future<UserData>? getUserProfile() async {
    var user = await store.get(StorageKeys.user);

    return UserData.fromJson((Map.from(user)));
  }

  Future<void> init() => store.init();
}
