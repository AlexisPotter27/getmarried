import 'package:getmarried/models/user.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';
  UserData currentData = UserData.generateData();

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
