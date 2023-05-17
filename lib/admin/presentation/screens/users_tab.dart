import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/screens/user_details_screen.dart';
import 'package:getmarried/admin/presentation/widgets/total_card.dart';
import 'package:getmarried/admin/presentation/widgets/user_item.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/widgets/error_widget.dart';
import 'package:iconsax/iconsax.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  AdminBloc adminBloc = getIt.get();
  List<UserData> users = [];

  @override
  void initState() {
    getIt.get<AdminBloc>().add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: getIt.get<AdminBloc>(),
        // buildWhen: (prev, curr) =>
        //     curr is GetAllUsersSuccessState ||
        //     curr is GetAllUsersLoadingState ||
        //     curr is UnblockUserSuccessState ||
        //     curr is UsersFetchedState ||
        //     curr is GetAllUsersFailureState,
        listener: (context, state) {
          if (state is GetAllUsersSuccessState) {
            setState(() {
              users = state.users;
            });

            adminBloc.add(ListenToUsersStreamEvent());
          }
          if (state is UsersFetchedState) {
            setState(() {
              users = state.users;
            });
          }
          if (state is GetAllUsersFailureState) {
            showCustomToast(state.error.toString());
          }
        },
        builder: (context, state) {
          if (state is GetAllUsersLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColour,
              ),
            );
          }

          if (state is GetAllUsersFailureState) {
            return AppPromptWidget(
              canTryAgain: true,
              onTap: () {
                getIt.get<AdminBloc>().add(GetUsersEvent());
              },
            );
          }

          if (users.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All  Users',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: inputDecoration(context).copyWith(
                      fillColor: Colors.grey.shade100,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search User'),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TotalCard(
                        tittle: 'Total Male',
                        value: users
                            .where((element) => element.gender == 'Man')
                            .length
                            .toString(),
                        gradient: LinearGradient(
                            end: Alignment.centerLeft,
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.indigo.shade300,
                              Colors.indigo.shade400,
                              Colors.indigo.shade400,
                              Colors.indigo,
                            ]),
                        icon: Icon(
                          Iconsax.woman,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TotalCard(
                        tittle: 'Total Female',
                        value: users
                            .where((element) => element.gender == 'Woman')
                            .length
                            .toString(),
                        icon: Icon(
                          Iconsax.man,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailsScreen(
                                    userData: users[index],
                                  ),
                                ));
                          },
                          child: UserItem(
                            userData: users[index],
                          )),
                    ),
                  ),
                )
              ],
            );
          } else {
            return AppPromptWidget(
              canTryAgain: true,
              message: 'There are no users yet',
              onTap: () {
                getIt.get<AdminBloc>().add(GetUsersEvent());
              },
            );
          }

        },
      ),
    );
  }
}
