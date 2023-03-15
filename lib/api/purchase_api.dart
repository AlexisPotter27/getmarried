import 'dart:async';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  /*static const _apiKey = '';
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);

  }

  static Future<List<Offering>> fetchOffers() async {
    try{
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }*/
  static const _apiKey = '116c64b63719480fbbeaad11ea28c7a0';

  static Future<void> init() async {
    await Glassfy.initialize(_apiKey, watcherMode: false);
  }

}