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
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/home/home_tab/date_filters_screen.dart';
import 'package:getmarried/widgets/chat/conversation_item.dart';
import 'package:getmarried/widgets/chat/user_chat_item.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  ChatBloc chatBloc = ChatBloc(ChatRepositoryImpl());
  UserData userData = getIt.get<CacheCubit>().user!;

  @override
  void initState() {
    super.initState();
    chatBloc.add(GetUsersEvent());
    chatBloc.add(GetConversationEvent(userData.uid!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            height: 40,
            width: 50,
          ),
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

        // floating: true,

        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DateFiltersScreen(),
                ));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                  size: 25,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text('SelectUser to start chat'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 70,
                child: BlocConsumer<ChatBloc, ChatState>(
                  bloc: chatBloc,
                  buildWhen: (prev, curr) =>
                      curr is UsersLoadingState ||
                      curr is UsersFetchedState ||
                      curr is UsersErrorState,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is UsersLoadingState) {
                      return const Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      );
                    }
                    if (state is UsersFetchedState) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              // chatBloc.add(GetConversationEvent());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessagingScreen(
                                      userData: state.users[index].toChatUser(),
                                    ),
                                  ));
                            },
                            child: UserChatItem(userData: state.users[index])),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: inputDecoration(context).copyWith(
                          fillColor: Colors.grey.shade200,
                          hintText: 'Search message',
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8)),
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(10.0),
                  //   child: Icon(
                  //     Icons.edit_note_outlined,
                  //     size: 30,
                  //     color: Colors.grey,
                  //   ),
                  // )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  bloc: chatBloc,
                  buildWhen: (prev, curr) =>
                      curr is ConversationLoadingState ||
                      curr is ConversationFetchedState ||
                      curr is ConversationErrorState,
                  builder: (context, state) {
                    if (state is ConversationLoadingState) {
                      return Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is ConversationFetchedState) {
                      return ListView.builder(
                        itemCount: state.conversations.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ConversationItem(
                          conversation: state.conversations[index],
                        ),
                      );
                    }
                    if (state is ConversationErrorState) {
                      return Center(
                        child: Text('An error occured'),
                      );
                    }

                    return SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
