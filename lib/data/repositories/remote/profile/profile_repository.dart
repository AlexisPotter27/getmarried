import 'package:getmarried/models/user.dart';

abstract class ProfileRepository {
  Future<void> cacheUser(UserData profile);

  Future<dynamic>? getLocalUserProfile();

  Future<dynamic>? getUserProfile();
}
