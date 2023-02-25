import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/presentation/screens/home/home_tab/date_filters_screen.dart';
import 'package:getmarried/widgets/home/match_card.dart';
import 'package:getmarried/widgets/home/swippable_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List items = [
    'assets/jpeg/person1.jpeg',
    'assets/jpeg/person2.jpeg',
    'assets/jpeg/girl.jpeg',
    'assets/jpeg/person2.jpeg',
    'assets/jpeg/girl.jpeg',
    'assets/jpeg/person2.jpeg',
    'assets/jpeg/girl.jpeg',
  ];
  late AnimationController controller;
  final animation = Tween<double>(begin: 400, end: 0);
  Offset likeButtonOffset = Offset(-(deviceWidth() / 2) - 50, 0);

  double disLikeScale = 0.5;
  double likeScale = 0.5;

  Offset disLikeButtonOffset = Offset((deviceWidth() / 2) + 50, 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    size: 25,
                  )),
              Expanded(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 40,
                    width: 50,
                  ),
                  const Text(
                    'Get Married',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primaryColour,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DateFiltersScreen(),
                    ));
                  },
                  icon: const Icon(
                    Icons.tune,
                    size: 25,
                  )),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Stack(
                  children: List.generate(
                      items.length,
                      (index) => SwipableCard(
                            onLiked: () {
                              setState(() {
                                items.removeLast();
                              });
                            },
                            color: Colors.black,
                            onPanUpdated: (DragUpdateDetails details) {
                              log('DX:${details.delta.dx}');
                              setState(() {
                                likeButtonOffset -= details.delta;
                                disLikeButtonOffset -= details.delta;
                                likeScale += details.delta.dx * 0.01;
                                disLikeScale -= details.delta.dx * 0.01;
                              });
                            },
                            onSwipeEnded: (details) {
                              endSwipe();
                            },
                            onDisLike: () {
                              setState(() {
                                items.removeLast();
                              });
                            },
                            child: MatchCard(
                              image: items[index],
                            ),
                          )).reversed.toList().reversed.toList(),
                ),
                Center(
                  child: Transform.translate(
                    offset: Offset(disLikeButtonOffset.dx - 10, 0),
                    child: Transform.scale(
                      scale: likeScale,
                      child: Stack(
                        children: const [
                          Center(
                            child: Icon(
                              Icons.favorite,
                              color: primaryColour,
                              size: 50,
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Transform.translate(
                    offset: Offset(likeButtonOffset.dx + 10, 0),
                    child: Transform.scale(
                      scale: disLikeScale,
                      child: const Center(
                        child: Icon(
                          Icons.thumb_down,
                          color: Colors.redAccent,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void endSwipe() {
    setState(() {
      likeButtonOffset = Offset(-(deviceWidth() / 2) - 50, 0);
      disLikeButtonOffset = Offset((deviceWidth() / 2) + 50, 0);
      likeScale = 0.5;
      disLikeScale = 0.5;
    });
  }
}
