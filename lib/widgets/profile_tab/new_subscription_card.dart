import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/helper/app_utils.dart';
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

class NewSubscriptionCard extends StatefulWidget {
  const NewSubscriptionCard(
      {Key? key,
        required this.tittle,
        required this.description,
        required this.buttonText,
        this.gradient, this.bgImage, required this.price,
        this.buttonTextColor})
      : super(key: key);
  final String tittle;
  final String description;
  final String buttonText;
  final String price;
  final Gradient? gradient;
  final String? bgImage;
  final Color? buttonTextColor;

  @override
  State<NewSubscriptionCard> createState() => _NewSubscriptionCardState();
}

class _NewSubscriptionCardState extends State<NewSubscriptionCard> {
  bool _isLoading = false;
  late Offerings offerings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(),
      padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
      decoration: BoxDecoration(
        color: widget.bgImage == null?primaryColour:null,
        borderRadius: BorderRadius.circular(5),
        image: widget.bgImage != null? DecorationImage(image: AssetImage(widget.bgImage!,),fit: BoxFit.cover):null,
        gradient: widget.gradient,
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
                        widget.tittle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        '365 days',
                        style: const TextStyle(

                            fontSize: 13,
                            color: Colors.white
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Row(children: [
                  Text(
                    '${widget.price}/',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                  Text(
                   'year',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                ],)
              ],
            ),
          Spacer(),
            Row(
              children: [
                TextButton(
                      style: TextButton.styleFrom(

                        backgroundColor: Colors.white,padding: EdgeInsets.symmetric(horizontal: 16,),),

                    onPressed: () {
                      // performPayment();
                      showCustomToast('These feature is free for the first 500 users Enjoy');
                    },
                    child: Text('Upgrade',style: TextStyle(color: widget.buttonTextColor??primaryColour),)),
                SizedBox(width: 10,),
                Text(
                  widget.description,

                  style: const TextStyle(fontSize: 14,color: Colors.white),
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
