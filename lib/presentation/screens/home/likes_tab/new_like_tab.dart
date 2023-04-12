import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/widgets/likes/liker_item.dart';
import 'package:getmarried/widgets/primary_button.dart';

class NewLikeTab extends StatefulWidget {
  const NewLikeTab({Key? key}) : super(key: key);

  @override
  State<NewLikeTab> createState() => _NewLikeTabState();
}

class _NewLikeTabState extends State<NewLikeTab> {
  ChatBloc chatBloc = ChatBloc(ChatRepositoryImpl());
  List<UserData> items = [];

  @override
  void initState() {
    chatBloc.add(GetUsersEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset(
                'assets/ilogo.png',
                height: 40,
                width: 50,
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Likes',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: primaryColour),
                ),
                SizedBox(
                  width: 10,
                ),
                // CircleAvatar(
                //     backgroundColor: primaryColour.withOpacity(0.2),
                //     radius: 15,
                //     child: Icon(
                //       Icons.favorite,
                //       size: 10,
                //       color: primaryColour,
                //     )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'This is the list of people who have like your profile, you can select a user to start up a conversation with them.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 16,
            ),
            BlocConsumer<ChatBloc, ChatState>(
              bloc: chatBloc,
              buildWhen: (prev, curr) =>
                  curr is UsersLoadingState ||
                  curr is UsersFetchedState ||
                  curr is UsersErrorState,
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
                  if (items.isNotEmpty) {
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            LikerItem(userData: items[index]),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.80,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                      ),
                    );
                  }
                  return Center(
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            const Text('You have no likes yet,'),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: 100,
                              child: PrimaryButton(
                                onPressed: () {
                                  chatBloc.add(GetUsersEvent());
                                },
                                child: const Text(
                                  'Refresh',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void sortUsers(List<UserData> fetchedUsers) {
    UserData user = getIt.get<CacheCubit>().user!;

    setState(() {
      items = fetchedUsers
          .where((element) =>
              element.gender != user.gender &&
              element.uid != user.uid &&
              element.likes!.contains(user.uid))
          .toList();
    });
  }
}
