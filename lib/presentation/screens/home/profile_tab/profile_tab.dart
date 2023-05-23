import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/models/singletons_data.dart';
import 'package:getmarried/models/styles.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/paywall.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/profile_settings_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/settings_screen.dart';
import 'package:getmarried/widgets/native_dialog.dart';
import 'package:getmarried/widgets/profile_tab/features_tile.dart';
import 'package:getmarried/widgets/profile_tab/new_subscription_card.dart';
import 'package:iconsax/iconsax.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int _selectedIndex = 0;
  var cachedUser = getIt.get<CacheCubit>().user!;
  late Offerings offerings;
  bool _isLoading = false;

  @override
  void initState() {
    // showCustomToast(getIt.get<CacheCubit>().user!.photos!.length.toString());
    // log();
    super.initState();
  }

  final _controller = PageController(
    viewportFraction: 0.90,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Center(
                child: Image.asset(
                  'assets/ilogo.png',
                  height: 55,
                  width: 55,
                ),
              ),

              // leading: GestureDetector(
              //     onTap: () {
              //       // scaffoldKey.currentState!.openDrawer();
              //     },
              //     child: const Icon(
              //       Icons.menu,
              //       color: Colors.grey,
              //       size: 25,
              //     )),

              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,

              // floating: true,

              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Iconsax.setting,
                        color: Colors.black,
                        size: 30,
                      ),
                    )),
              ],
              expandedHeight: 290,
              collapsedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            getIt.get<CacheCubit>().user!.photos![0].toString(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              getIt
                                  .get<CacheCubit>()
                                  .user!
                                  .firstname
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // const Icon(
                            //   Icons.security,
                            //   size: 16,
                            //   color: Colors.grey,
                            // )
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileSettingsScreen(),
                            ));
                          },
                          child: Chip(
                            label: const Text(
                              'Complete my profile',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: primaryColour,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )),
            ),

            // SliverToBoxAdapter(
            //   child: Center(
            //     child: Column(
            //       children: [
            //         Image.asset(
            //           'assets/lovers.png',
            //           height: 200,
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           'Get married is free for the first 500 users',
            //           style: TextStyle(fontSize: 16),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Row(
                    //   children: const [
                    //     Expanded(child: CardTile()),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(child: CardTile())
                    //   ],
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 150,
                      child: PageView(
                        padEnds: false,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        controller: _controller,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: NewSubscriptionCard(
                              tittle: 'Premium',
                              description: 'Free for first 500 users',
                              // bgImage: 'assets/upgrade_bg.jpeg',

                              gradient: LinearGradient(
                                  end: Alignment.centerLeft,
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.indigo.shade300,
                                    Colors.indigo.shade400,
                                    Colors.indigo.shade400,
                                    Colors.indigo,
                                  ]),
                              buttonText: 'Upgrade for ONLY \$2,500/year.',
                              price: '\$2,500',
                            ),
                          ),
                          NewSubscriptionCard(
                              buttonTextColor: Colors.cyan,
                              tittle: 'Boost',
                              gradient: LinearGradient(
                                  end: Alignment.centerLeft,
                                  begin: Alignment.centerRight,
                                  colors: [
                                    Colors.cyan.shade300,
                                    Colors.cyan.shade300,
                                    Colors.cyan.shade400,
                                    Colors.cyan,
                                  ]),
                              description: 'Free for first 500 users',
                              buttonText: 'Upgrade for ONLY \$2,500/year.',
                              price: '\$2,500'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    cachedUser.getPercentage() >= 75
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'What you will get:',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = 0;
                                        _controller.jumpToPage(0);
                                      });
                                    },
                                    child: const Text(
                                      'Premium',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = 1;
                                        _controller.jumpToPage(1);
                                      });
                                    },
                                    child: const Text(
                                      'Boost',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            // const FlexibleSpaceBar(),
            cachedUser.getPercentage() >= 75
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: FeaturesTile(
                          featureModel: features[index],
                          selectedFeature: _selectedIndex,
                        ),
                      ),
                      childCount: features.length,
                    ),
                  )
                : SliverToBoxAdapter(),
          ],
        ),
      ),
    );
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
        if (offerings.current != null) {
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
