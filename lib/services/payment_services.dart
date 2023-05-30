// import 'dart:io';
//
// import 'package:getmarried/di/injector.dart';
// import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
//
// class PaymentServices {
//
//    PaymentServices();
//
//   Future<void> init() async {
//     int? userId = 2;
//
//     String? email = getIt.get<CacheCubit>().user?.email;
//     String? displayName = getIt.get<CacheCubit>().user?.firstname;
//
//     late final PurchasesConfiguration purchaseConfig;
//     if (Platform.isAndroid) {
//       purchaseConfig =
//           PurchasesConfiguration("goog_brurElscbAFgxsuPonOPivXlPds");
//     } else if (Platform.isIOS) {
//       purchaseConfig =
//           PurchasesConfiguration("appl_HrOEKIOWyOvuTklJuyeuveaeOji");
//     }
//     await Purchases.configure(purchaseConfig..appUserID = "${userId ?? ""}");
//     await Purchases.setLogLevel(LogLevel.debug);
//
//     Purchases.setEmail(email ?? "");
//     Purchases.setDisplayName(displayName ?? "");
//   }
//
//   bool isSubcriptionActive(CustomerInfo customerInfo,
//       {List<String>? entitlements}) {
//     if (entitlements == null) {
//       return customerInfo.entitlements.active.isNotEmpty;
//     }
//     return customerInfo.entitlements.active.keys
//         .any((key) => entitlements.contains(key));
//   }
//
//   Future<CustomerInfo> purchasePackage(Package package) async {
//     return await Purchases.purchasePackage(package);
//   }
//
//   Future<CustomerInfo> purchaseProduct(String identifier,
//       {required PurchaseType type}) async {
//     return await Purchases.purchaseProduct(identifier, type: type);
//   }
// }
