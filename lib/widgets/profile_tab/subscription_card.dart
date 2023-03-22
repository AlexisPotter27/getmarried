import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/presentation/paywall.dart';
import 'package:getmarried/widgets/upgrade_button.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../constant.dart';
import '../../models/singletons_data.dart';
import '../../models/styles.dart';
import '../../models/user.dart';
import '../native_dialog.dart';

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard(
      {Key? key,
      required this.tittle,
      required this.description,
      required this.buttonText,
      this.gradient})
      : super(key: key);
  final String tittle;
  final String description;
  final String buttonText;
  final Gradient? gradient;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  bool _isLoading = false;
  late Offerings offerings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColour,
        borderRadius: BorderRadius.circular(16),
        gradient: widget.gradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.tittle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.1),
            child: UpgradeButton(
                onPressed: () {
                  performPayment();
                },
                child: Text(widget.buttonText)),
          )
        ],
      ),
    );
  }

  /*
    We should check if subscription active and if not, display the paywall.
  */

  void performPayment() async {
    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      appData.currentData = UserData.generateData();
      setState(() {
        _isLoading = false;
      });
    } else {
      //Offerings? offerings;
      try {
        setState(() {
          _isLoading = false;
        });
        Offerings offerings = await Purchases.getOfferings();
        if (offerings != null && offerings.current != null) {
          await showModalBottomSheet(
            useRootNavigator: true,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: kColorBackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    return Paywall(
                      offering: offerings.current!,
                    );
                  });
            },
          );
        } else {
          // offerings are empty, show a message to your user
          ToastMessage.showToast('There is no offering.');
        }
      } on PlatformException catch (e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: "Error",
                content: e.message.toString(),
                buttonText: 'OK'));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
