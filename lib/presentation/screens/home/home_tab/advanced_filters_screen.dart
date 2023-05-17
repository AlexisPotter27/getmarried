import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/date_filters.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/date/children_bottomsheet.dart';
import 'package:getmarried/widgets/date/drink_bottomsheet.dart';
import 'package:getmarried/widgets/date/education_bottomsheet.dart';
import 'package:getmarried/widgets/date/excercise_bottomsheet.dart';
import 'package:getmarried/widgets/date/religion_bottomsheet.dart';
import 'package:getmarried/widgets/date/settings_tile.dart';
import 'package:getmarried/widgets/date/smoke_bottomsheet.dart';
import 'package:getmarried/widgets/date/star_sign_bottomsheet.dart';
import 'package:getmarried/widgets/date/topics_bottomsheet.dart';
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

class AdvancedFiltersScreen extends StatefulWidget {
  const AdvancedFiltersScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedFiltersScreen> createState() => _AdvancedFiltersScreenState();
}

class _AdvancedFiltersScreenState extends State<AdvancedFiltersScreen> {
  DateFilters? filters = getIt.get<CacheCubit>().user!.dateFilters;
  AuthBloc authBloc = getIt.get<AuthBloc>();
  bool verifiedOnly = true;
  bool _isLoading = false;
  late Offerings offerings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
              width: 50,
            ),
            const Text(
              'Advanced filters',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColour,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // SettingsTile(
                    //   text: 'Verified profiles only',
                    //   prefixIcon: const Icon(
                    //     Icons.health_and_safety_rounded,
                    //     color: Colors.black45,
                    //   ),
                    //   suffixIcon: SizedBox(
                    //       height: 25,
                    //       child: Transform.scale(
                    //         scale: 0.8,
                    //         child: CupertinoSwitch(
                    //           value: filters!.verifiedOnly ?? false,
                    //           onChanged: (val) {
                    //             setState(() {
                    //               filters!.verifiedOnly = val;
                    //             });
                    //           },
                    //           activeColor: primaryColour,
                    //         ),
                    //       )),
                    //   onPressed: () {},
                    //   tittle: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: const [
                    //         Text(
                    //           'Have they verified themselves ?',
                    //           style: TextStyle(fontSize: 13),
                    //         ),
                    //         Text(
                    //           'What\'s this',
                    //           style: TextStyle(
                    //               decoration: TextDecoration.underline,
                    //               fontSize: 13),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // SettingsTile(
                    //   text: 'Add this filter',
                    //   suffixIcon: filters!.height == null
                    //       ? Icon(
                    //           Icons.add,
                    //           color: Colors.grey.shade300,
                    //         )
                    //       : Text(filters!.height!),
                    //   prefixIcon: Transform.rotate(
                    //       angle: 50,
                    //       child: const Icon(
                    //         Icons.straighten,
                    //         color: Colors.black45,
                    //       )),
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) => const HeightBottomSheet(),
                    //         backgroundColor: Colors.transparent);
                    //   },
                    //   tittle: const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text(
                    //       'What is their height ?',
                    //       style: TextStyle(
                    //           fontSize: 13, fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.excercise == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.excercise!),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ExerciseBottomSheet(
                                  onExerciseSelected: (String exercise) {
                                    // Navigator.pop(context);
                                    setState(() {
                                      filters!.excercise = exercise;
                                      updateFilters();
                                    });
                                    // authBloc.add(UpdateUserEvent());
                                  },
                                  value: filters!.excercise,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they exercise ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.education == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.education!),
                      prefixIcon: const Icon(
                        Icons.school_outlined,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => EducationBottomSheet(
                                  onEducationSelected: (String excerise) {
                                    setState(() {
                                      filters!.education = excerise;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.education,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their education ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.drink == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.drink!),
                      prefixIcon: const Icon(
                        Icons.wine_bar,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => DrinkBottomSheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.drink = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.drink,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they drink ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.smoke == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.smoke!),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.smoking_rooms,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => SmokeBottomScheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.smoke = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.smoke,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they smoke ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // SettingsTile(
                    //   text: 'Add this filter',
                    //   suffixIcon: filters!.lookingFor == null
                    //       ? Icon(
                    //           Icons.add,
                    //           color: Colors.grey.shade300,
                    //         )
                    //       : Text(filters!.lookingFor!),
                    //   prefixIcon: Transform.rotate(
                    //       angle: 50,
                    //       child: const Icon(
                    //         Icons.search,
                    //         color: Colors.black45,
                    //       )),
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) => NeedsBottomSheet(
                    //               onSelected: (String value) {
                    //                 setState(() {
                    //                   filters!.lookingFor = value;
                    //                 });
                    //               },
                    //               value: filters!.lookingFor,
                    //             ),
                    //         backgroundColor: Colors.transparent);
                    //   },
                    //   tittle: const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text(
                    //       'What is do you want from your  get married?',
                    //       style: TextStyle(
                    //           fontSize: 13, fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.children == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.children!),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.baby_changing_station,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ChildrenBottomsheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.children = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.children,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they have children ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.startSign == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.startSign!),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.diamond_outlined,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => StarSignBottomSheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.startSign = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.startSign,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their star sign ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.topics == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.topics!),
                      prefixIcon: const Icon(
                        Icons.account_balance_rounded,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => TopicsBottomSheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.topics = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.topics,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What are their topics like  ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: filters!.religion == null
                          ? Icon(
                              Icons.add,
                              color: Colors.grey.shade300,
                            )
                          : Text(filters!.religion!),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.sign_language_outlined,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ReligionBottomSheet(
                                  onSelected: (String value) {
                                    setState(() {
                                      filters!.religion = value;
                                      updateFilters();
                                    });
                                  },
                                  value: filters!.religion,
                                ),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their religion ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                left: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // performPayment();
                    },
                    style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: primaryColour,
                        primary: Colors.black),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Upgrade for advanced filters'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*
    We should check if subscription active and if not, display the paywall.
  */

  void updateFilters(){
    UserData userData = getIt.get<CacheCubit>().user!.copyWith(dateFilters: filters);
    getIt.get<CacheCubit>().updateUser(userData);
    getIt.get<AuthBloc>().add(UpdateUserEvent(userData));

  }


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
