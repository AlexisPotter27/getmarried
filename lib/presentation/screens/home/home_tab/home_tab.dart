import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/presentation/blocs/matching/matching_bloc.dart';
import 'package:getmarried/presentation/blocs/swipe_controller/swipe_bloc.dart';
import 'package:getmarried/presentation/screens/home/home_tab/date_filters_screen.dart';
import 'package:getmarried/widgets/error_widget.dart';
import 'package:getmarried/widgets/home/match_card.dart';
import 'package:getmarried/widgets/home/swippable_card.dart';
import 'package:getmarried/widgets/primary_button.dart';
import 'package:iconsax/iconsax.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ChatBloc chatBloc = ChatBloc(ChatRepositoryImpl());
  SwipeController swipeBloc = SwipeController();
  UserData cachedUser = getIt.get<CacheCubit>().user!;
  MatchingBloc _matchingBloc = MatchingBloc(getIt.get());

  @override
  void initState() {
    super.initState();
    chatBloc.add(GetUsersEvent());
  }

  List<UserData> items = [];
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
              // IconButton(
              //     onPressed: () {
              //       // scaffoldKey.currentState!.openDrawer();
              //     },
              //     icon: const Icon(
              //       Icons.menu,
              //       size: 30,
              //     )),
              Expanded(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ilogo.png',
                    height: 55,
                    width: 55,
                  ),
                  /*const Text(
                        'Get Married',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primaryColour,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),*/
                ],
              )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DateFiltersScreen(),
                    ));
                  },
                  icon: const Icon(
                    Iconsax.filter,
                    size: 30,
                  )),
            ],
          ),
          BlocConsumer<ChatBloc, ChatState>(
            bloc: chatBloc,
            listener: (context, state) {
              if (state is UsersFetchedState) {
                sortUsers(state.users);
              }
            },
            builder: (context, state) {
              if (state is UsersErrorState) {
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        const Text('An error occured'),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButton(
                          onPressed: () {
                            chatBloc.add(GetUsersEvent());
                          },
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (state is UsersLoadingState) {
                return const Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              return Expanded(
                child: items.isNotEmpty
                    ? Stack(
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(),
                                alignment: Alignment.center,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      const Text('You are caught up'),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: PrimaryButton(
                                          padding: EdgeInsets.all(5),
                                          onPressed: () {
                                            chatBloc.add(GetUsersEvent());
                                          },
                                          child: const Text(
                                            'Refresh',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ...List.generate(items.length, (index) {
                                final controller = SwipeController();
                                return SwipableCard(
                                  onLiked: () {
                                    likeUser(items[index]);

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
                                  onSwipeEnded: () {
                                    endSwipe();
                                  },
                                  onDisLike: () {
                                    dislikeUser(items[index]);
                                    setState(() {
                                      items.removeLast();
                                    });
                                  },
                                  swipeController: controller,
                                  child: MatchCard(
                                    user: items[index],
                                    onLiked: () {
                                      likeUser(items[index]);
                                      controller.add(LikeEvent());
                                    },
                                    onDisLiked: () {
                                      dislikeUser(items[index]);
                                      controller.add(DisLikeEvent());
                                    },
                                  ),
                                );
                              }).reversed.toList().reversed.toList(),
                            ],
                          ),
                          Center(
                            child: Transform.translate(
                              offset: Offset(disLikeButtonOffset.dx - 10, 0),
                              child: Transform.scale(
                                scale: likeScale,
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                    radius: 30,
                                    child: Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                          Center(
                            child: Transform.translate(
                              offset: Offset(likeButtonOffset.dx + 10, 0),
                              child: Transform.scale(
                                scale: disLikeScale,
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                    radius: 30,
                                    child: Icon(
                                      Icons.thumb_down,
                                      size: 25,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: AppPromptWidget(
                            canTryAgain: true,
                            isSvgResource: false,
                            imagePath: 'assets/no_match.png',
                            message: 'You have no match currently',
                            onTap: () {
                              chatBloc.add(GetUsersEvent());
                            }),
                      ),
              );
            },
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

  void sortUsers(List<UserData> fetchedUsers) {
    UserData user = getIt.get<CacheCubit>().user!;

    setState(() {
      items = fetchedUsers
          .where((element) =>
              (element.gender != user.gender && element.uid != user.uid) &&
              (!element.matches!.contains(user.uid)))
          .toList();

      items = items
          .where((element) => (!element.likeMe!.contains(user.uid)))
          .toList();
      log(items.length.toString());
      items = items
          .where((element) => !element.dislikes!.contains(user.uid.toString()))
          .toList();
    });
    // log(fetchedUsers
    //     .where((element) => (!element.dislikes!.contains(user.uid.toString())) && (!element.likeMe!.contains(user.uid)))
    //     .length
    //     .toString());
    // log(fetchedUsers
    //     .where((element) => (!element.matches!.contains(user.uid)))
    //     .length
    //     .toString());
    // log(fetchedUsers
    //     .where((element) =>
    //         (element.gender != user.gender && element.uid != user.uid))
    //     .length
    //     .toString());
  }

  void likeUser(UserData swipedUser) {
    UserData user = getIt.get<CacheCubit>().user!;

    _matchingBloc.add(
        LikeUserEvent(uid: swipedUser.uid!, match: userHasLikedMe(swipedUser)));
    if (userHasLikedMe(swipedUser)) {
      // TODO: MATCH USER AND LIKE
      showMatchedDialog(context, swipedUser, user);
    } else {
      //TODO: LIKE USER
    }
  }

  void dislikeUser(UserData swipedUser) {
    UserData user = getIt.get<CacheCubit>().user!;
    if (!swipedUser.dislikes!.contains(user.uid)) {
      _matchingBloc.add(DisLikeUserEvent(
        swipedUser.uid!,
      ));
    }
  }

  bool userHasLikedMe(UserData userData) {
    UserData me = getIt.get<CacheCubit>().user!;
    return userData.likes!.contains(me.uid);
  }
}
