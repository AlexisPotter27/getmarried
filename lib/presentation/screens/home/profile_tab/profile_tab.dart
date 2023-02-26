import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
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
        padding: const EdgeInsets.all(16.0),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.menu,
                              color: Colors.blue,
                              size: 25,
                            )),
                        Image.asset('assets/ilogo.png',height: 40,width: 50,),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.settings,
                              color: Colors.blue,
                              size: 25,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/jpeg/person1.jpeg',),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SubscriptionCard(
                              tittle: '50% off Premium',
                              description: 'Offer ends in 12:12:27',
                              buttonText: 'Upgrade for 8.59 USD',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            buttonText: 'Upgrade for 3.91 USD',
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
              )
            ];
          },
          body: ListView.builder(
            itemCount: features.length,
            itemBuilder: (context, index) => FeaturesTile(
              featureModel: features[index],
              selectedFeature: _selectedIndex,
            ),
          ),
        ),
      ),
    );
  }
}
