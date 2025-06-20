import 'dart:developer';

import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/data/repositories/local/hive_store.dart';
import 'package:getmarried/data/repositories/local/share_preference_store.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/models/user.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final store = SharedPreferenceStore();

  // FirebaseStorage storage

  ProfileRepositoryImpl() {
    init();
  }

  @override
  Future<void> cacheUser(UserData profile) async {
    await store.set(StorageKeys.user, profile.toJson());
    log('USER ID${profile.uid.toString()}');
  }

  @override
  Future<UserData>? getLocalUserProfile() async {
    var user = await store.get(StorageKeys.user);
    return UserData.fromJson((Map.from(user)));
  }

  Future<void> init() => store.init();

  @override
  Future? getUserProfile() {
    throw UnimplementedError();
  }
}
