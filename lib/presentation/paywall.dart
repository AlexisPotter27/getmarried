import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/presentation/cubits/in_app_payment/in_app_payment_cubit.dart';
import 'package:getmarried/widgets/primary_button.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../constant.dart';
import '../models/singletons_data.dart';
/*import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';*/
import '../models/styles.dart';

class Paywall extends StatefulWidget {
  final String? plan;
  final Offering offering;

  const Paywall({
    Key? key,
    this.plan,
    required this.offering,
  }) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  final InAppPaymentCubit _appPaymentCubit = InAppPaymentCubit(getIt.get());
  String _selectedProductId = '';

  @override
  void initState() {
    // setState(() {
    //   _selectedProductId =
    //       widget.offering.availablePackages.first.storeProduct.identifier;
    // });
    super.initState();

    // _appPaymentCubit.fetchOfferings();
  }

  @override
  Widget build(BuildContext context) {
    var myProductList = widget.offering.availablePackages;
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              child: Center(
                  child: Text('✨ GetMarriedApp Upgrade',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500))),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Center(
                  child: Text(
                    'Unlock all of our features to be in complete control of your experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: myProductList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedProductId =
                          myProductList[index].storeProduct.identifier;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: isActive(
                                  myProductList[index].storeProduct.identifier)
                              ? primaryColour
                              : Colors.black12,
                          width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: isActive(myProductList[index]
                                        .storeProduct
                                        .identifier)
                                    ? 1
                                    : 0,
                                groupValue: 1,
                                fillColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return primaryColour;
                                  }
                                  return Colors.black12;
                                }),
                                activeColor: Colors.white,
                                onChanged: (value) {},
                              ),
                              Text(myProductList[index].storeProduct.title,
                                  style: TextStyle(
                                      color: isActive(myProductList[index]
                                              .storeProduct
                                              .identifier)
                                          ? primaryColour
                                          : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "${myProductList[index].storeProduct.priceString}/${myProductList[index].packageType.name}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10))
                        ]))
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<InAppPaymentCubit, InAppPaymentState>(
                bloc: _appPaymentCubit,
                listener: (context, state) {
                  if (state is InAppPaymentError) {
                    showCustomToast('Subscription Error');
                    // AppUtils.showErrorDialog(context,
                    //     message: state.error.errorMessage,
                    //     title: "Subscription Error",
                    //     confirmButtonText: "Close",
                    //     onConfirmed: () => Navigator.pop(context));
                  }
                  if (state is InAppPurchaseSuccess) {
                    Navigator.pop(context, true);
                  }
                },
                builder: (context, state) {
                  return SafeArea(
                    top: false,
                    child: PrimaryButton(
                        // color: Theme.of(context).colorScheme.secondary,
                        padding: EdgeInsets.all(16),
                        onPressed: state is InAppPaymentLoading
                            ? null
                            : () {
                                if (_selectedProductId.isNotEmpty) {
                                  _appPaymentCubit
                                      .purchaseStoreProduct(_selectedProductId);
                                } else {
                                  showCustomToast('Select Plan');
                                }
                              },
                        // radius: 32,
                        // isBusy: state is InAppPaymentLoading,
                        child: Text(
                          state is InAppPaymentLoading
                              ? "Processing"
                              : "Subscribe Now",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  );
                },
              ),
            ),
            // const Padding(
            //   padding:
            //       EdgeInsets.only(top: 12, bottom: 16, left: 16.0, right: 16.0),
            //   child: SizedBox(
            //     child: Text(
            //       footerText,
            //       style:TextStyle(color: Colors.black),
            //     ),
            //     width: double.infinity,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  bool isActive(String id) => id == _selectedProductId;
}
