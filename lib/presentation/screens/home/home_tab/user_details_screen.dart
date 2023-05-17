import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/presentation/blocs/matching/matching_bloc.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:getmarried/widgets/error_widget.dart';
import 'package:getmarried/widgets/home/about_chip.dart';
import 'package:getmarried/widgets/primary_button.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen(
      {Key? key, required this.userId, this.showMesageButton = true})
      : super(key: key);
  final String userId;
  final bool? showMesageButton;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserData cachedUser = getIt.get<CacheCubit>().user!;
  MatchingBloc _matchingBloc = MatchingBloc(getIt.get());
  ChatBloc chatBloc = ChatBloc(ChatRepositoryImpl());

  // UserData? user;

  @override
  void initState() {
    chatBloc.add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          if (state is UsersFetchedState) {
            sortUsers(state.users);
          }
        },
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return const Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: primaryColour,
                  )),
            );
          }
          if (state is UsersFetchedState) {
            var user = state.users
                .where((element) => element.uid == widget.userId)
                .toList()
                .first;
            return Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: getDeviceSize(context: context).height *
                                    0.4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            user.photos!.isNotEmpty
                                                ? user.photos![0]
                                                : ''),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${user.firstname!},',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            user.age!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                          // Container(
                                          //   // margin: const EdgeInsets.all(16),
                                          //   height: 10,
                                          //   width: 50,
                                          //   decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(5),
                                          //       color: Colors.white),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.school_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              user.education ??
                                                  'No education info',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(20),
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 16,
                                    color: Colors.white,
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: primaryColour),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'About',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  user.about ?? 'Nothing to show here.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Interested in',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                      user.interests!.length,
                                      (index) => AboutChip(
                                            bgColor: Colors.indigo.shade100,
                                            label: user.interests![index],
                                          )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Basics',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                      1,
                                      (index) => AboutChip(
                                            bgColor: Colors.indigo.shade100,
                                            label: 'Cool',
                                          )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Languages',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                      1,
                                      (index) => AboutChip(
                                            bgColor: Colors.indigo.shade100,
                                            label: 'English',
                                          )),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                widget.showMesageButton!
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // GestureDetector(
                            //   onTap: (){
                            //     dislikeUser(widget.user);
                            //     showCustomToast('Disliked user');
                            //     Navigator.pop(context);
                            //   },
                            //   child: CircleAvatar(
                            //     backgroundColor: Colors.red.withOpacity(0.3),
                            //     radius: 30,
                            //     child: Icon(
                            //       Icons.thumb_down_alt_rounded,
                            //       color: Colors.red,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: PrimaryButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidComment,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Send a message',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessagingScreen(
                                          userData: user.toChatUser()),
                                    ));
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            )),
                            SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                likeUser(user);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.3),
                                radius: 30,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            );
          }

          return Column(
            children: [
              Expanded(
                child: Center(
                  child: AppPromptWidget(
                      canTryAgain: true,
                      message: 'Ann error occured please retry',
                      onTap: () {
                        chatBloc.add(GetUsersEvent());
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void likeUser(UserData swipedUser) {
    UserData user = getIt.get<CacheCubit>().user!;

    _matchingBloc.add(LikeUserEvent(uid: swipedUser.uid!, match: true));
    showMatchedDialog(context, swipedUser, user);
  }

  void sortUsers(List<UserData> fetchedUsers) {
    UserData user = getIt.get<CacheCubit>().user!;

    setState(() {
      List<UserData>? items = [];
      items = fetchedUsers
          .where((element) => element.uid == widget.userId)
          .toList();
      user = items.first;
      log(user.uid.toString());
    });
  }

  void dislikeUser(UserData swipedUser) {
    UserData user = getIt.get<CacheCubit>().user!;
    if (!swipedUser.dislikes!.contains(widget.userId)) {
      _matchingBloc.add(DisLikeUserEvent(
        swipedUser.uid!,
      ));
    }
  }
}
