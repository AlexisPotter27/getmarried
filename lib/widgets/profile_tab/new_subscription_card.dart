import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/presentation/cubits/in_app_payment/in_app_payment_cubit.dart';
import 'package:getmarried/presentation/paywall.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class NewSubscriptionCard extends StatefulWidget {
  const NewSubscriptionCard(
      {Key? key,
      required this.tittle,
      required this.description,
      this.gradient,
      this.buttonTextColor,
      this.productId,
      this.onTap,
      required this.offering, required this.color})
      : super(key: key);
  final String tittle;
  final String description;


  final Gradient? gradient;
  final Color? buttonTextColor;
  final MaterialColor color;
  final VoidCallback? onTap;
  final String? productId;
  final Offering offering;

  @override
  State<NewSubscriptionCard> createState() => _NewSubscriptionCardState();
}

class _NewSubscriptionCardState extends State<NewSubscriptionCard> {
  bool _isLoading = false;

  // final List<String> _subIds = [
  //   'com.creativemovers.m7',
  // ];

  String? _selectedProductId;
  final InAppPaymentCubit _appPaymentCubit = InAppPaymentCubit(getIt.get());

  @override
  void initState() {
    super.initState();
    // _selectedProductId = _subIds.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(5),

        gradient: LinearGradient(
            end: Alignment.centerLeft,
            begin: Alignment.bottomRight,
            colors: [
             widget.color.shade300,
              widget.color.shade400,
              widget.color.shade400,
              widget.color,
            ]
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${widget.offering.monthly?.storeProduct.title}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      Text(
                        '30 days',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Row(
                  children: [
                    Text(
               '${widget.offering.monthly?.storeProduct.priceString}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    // Text(
                    //   'year',
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    onPressed: () {
                      _pay();
                      // showCustomToast('These feature is free for the first 500 users Enjoy');
                    },
                    child: Text(
                      'Upgrade',
                      style: TextStyle(
                          color: widget.buttonTextColor ?? primaryColour),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
    ;
  }

  /*
    We should check if subscription active and if not, display the paywall.
  */

  void _pay() {
    showModalBottomSheet(
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Paywall(
            offering: widget.offering,

          );
        });
      },
    );
  }

// void performPayment() async {
//   setState(() {
//     _isLoading = true;
//   });
//
//   CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//
//   if (customerInfo.entitlements.all[entitlementID] != null &&
//       customerInfo.entitlements.all[entitlementID]?.isActive == true) {
//     appData.currentData = UserData.generateData();
//     setState(() {
//       _isLoading = false;
//     });
//   } else {
//     Offerings? offerings;
//     try {
//       setState(() {
//         _isLoading = false;
//       });
//       Offerings offerings = await Purchases.getOfferings();
//       if (offerings.current != null) {
//         await showModalBottomSheet(
//           useRootNavigator: true,
//           isDismissible: true,
//           isScrollControlled: true,
//           backgroundColor: kColorBackground,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//           ),
//           context: context,
//           builder: (BuildContext context) {
//             return StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setModalState) {
//               return Paywall(
//                 offering: offerings.current!,
//               );
//             });
//           },
//         );
//       } else {
//         // offerings are empty, show a message to your user
//         ToastMessage.showToast('There is no offering.');
//       }
//     } on PlatformException catch (e) {
//       await showDialog(
//           context: context,
//           builder: (BuildContext context) => ShowDialogToDismiss(
//               title: "Error",
//               content: e.message.toString(),
//               buttonText: 'OK'));
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
}
