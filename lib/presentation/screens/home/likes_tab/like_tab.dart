import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../../constant.dart';
import '../../../../helper/toastMessage.dart';
import '../../../../models/singletons_data.dart';
import '../../../../models/styles.dart';
import '../../../../models/user.dart';
import '../../../../widgets/native_dialog.dart';
import '../../../paywall.dart';

class LikeTab extends StatefulWidget {
  const LikeTab({Key? key}) : super(key: key);

  @override
  State<LikeTab> createState() => _LikeTabState();
}

class _LikeTabState extends State<LikeTab> {
  int _currentIndex = 0;

  bool _isLoading = false;
  late Offerings offerings;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 25,
                            )),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/ilogo.png',
                              height: 40,
                              width: 50,
                              color: Colors.yellow,
                            ),
                            /*const Text(
                              'Get Married',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),*/
                          ],
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'See who liked you with 50% off',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '3 people already liked you.',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      performPayment();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: const [
                          Text(
                            'Upgrade For',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            '8.59 USD',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Chip(
                    label: Text('Offer ends in 4:51:00'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'All 3',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: _currentIndex == 1
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            backgroundColor:
                                _currentIndex == 0 ? Colors.blue : Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'New 1',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: _currentIndex == 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            backgroundColor:
                                _currentIndex == 1 ? Colors.blue : Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Nearby',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: _currentIndex == 2
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            backgroundColor:
                                _currentIndex == 2 ? Colors.black : Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Recently active',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: _currentIndex == 3
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            backgroundColor:
                                _currentIndex == 3 ? Colors.black : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: 6,
                  //   padding: EdgeInsets.zero,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) => const LikerItem(),
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2,
                  //           childAspectRatio: 0.80,
                  //           mainAxisSpacing: 10,
                  //           crossAxisSpacing: 10),
                  // ),
                ],
              ),
            )
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
