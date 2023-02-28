import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/card_form_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/profile_settings_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/settings_screen.dart';
import 'package:getmarried/widgets/profile_tab/card_tile.dart';
import 'package:getmarried/widgets/profile_tab/features_tile.dart';
import 'package:getmarried/widgets/profile_tab/subscription_card.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int _selectedIndex = 0;

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
              //title: const Text('Sonia',style: TextStyle(color: Colors.black),),
              leading: GestureDetector(
                  onTap: () {

                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 30,
                  )),
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
                        Icons.settings,
                        color: Colors.grey,
                        size: 30,
                      ),
                    )),
              ],
              expandedHeight: 270,
              collapsedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/jpeg/person1.jpeg'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Sonia, 23',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.security,
                              size: 16,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Chip(
                          label: const Text(
                            'Complete my profile',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )),
            ),

            /*SliverAppBar(
              title: const Text(
                'Sonia',
                style: TextStyle(color: Colors.black),
              ),

              leading: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 25,
                  )),
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
                        Icons.settings,
                        color: Colors.grey,
                        size: 25,
                      ),
                    )),
              ],
              expandedHeight: 270,
              collapsedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/jpeg/person1.jpeg'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Sonia, 23',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.security,
                              size: 16,
                              color: Colors.grey,
                            )
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
                                color: Colors.grey,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                     ],
                  )),
            ),*/

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(child: CardTile()),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CardTile())
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 160,
                      child: PageView(
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        controller: _controller,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CardFormScreen(),
                                ));
                              },
                              child: const SubscriptionCard(
                                tittle: '50% off Premium',
                                description: 'Offer ends in 12:12:27',
                                buttonText: 'Upgrade for 12.51 USD',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CardFormScreen(),
                              ));
                            },
                            child: SubscriptionCard(
                              tittle: 'Boost',
                              gradient: LinearGradient(
                                  end: Alignment.bottomRight,
                                  begin: Alignment.topLeft,
                                  colors: [
                                    Colors.cyan.shade200,
                                    Colors.cyan.shade400,
                                    Colors.cyan,
                                    Colors.cyan,
                                  ]),
                              description:
                                  'More chances to match with extra features to boost your profile',
                              buttonText: 'Upgrade from 8.25 USD',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                                style: TextStyle(fontWeight: FontWeight.w500),
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
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            // const FlexibleSpaceBar(),
            SliverList(
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
            ),
            SliverList(
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
            ),
          ],
        ),
      ),
    );
  }
}
