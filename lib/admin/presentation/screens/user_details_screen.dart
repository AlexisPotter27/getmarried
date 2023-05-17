import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/widgets/user_details_item.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var bloc = AdminBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is UnblockUserSuccessState || state is DisableUserSuccessState) {
            showCustomToast('Successful',Colors.green);
            Navigator.pop(context);
            getIt.get<AdminBloc>().add(GetUsersEvent());

          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: widget.userData.accountDisabled!
                        ? TextButton(
                      onPressed: () {
                        bloc.add(UnblockUserEvent(widget.userData.uid!));
                      },
                      child: state is UnblockUserLoadingState
                          ? SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                          : Text(
                        'Enable',
                        style: TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
                      style:
                      TextButton.styleFrom(backgroundColor: Colors.green),
                    )
                        : TextButton(
                      onPressed: () {
                        bloc.add(DisableUserEvent(widget.userData.uid!));
                      },
                      child: state is DisableUserLoadingState
                          ? SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                          : Text(
                        'Disable',
                        style: TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
                      style:
                      TextButton.styleFrom(backgroundColor: Colors.red),
                    ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                widget.userData.photos!.first),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        UserDetailsItem(
                          tittle: 'Email',
                          value: widget.userData.email ?? 'None',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UserDetailsItem(
                          tittle: 'Name',
                          value: widget.userData.firstname ?? "None",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UserDetailsItem(
                          tittle: 'Gender',
                          value: widget.userData.gender ?? "None",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UserDetailsItem(
                          tittle: 'Age',
                          value: widget.userData.age ?? "None",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UserDetailsItem(
                          tittle: 'Education',
                          value: widget.userData.education ?? "None",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UserDetailsItem(
                          tittle: 'Religion',
                          value: widget.userData.religion ?? "None",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // UserDetailsItem(
                        //   tittle: 'Religion',
                        //   value: 'Christian',
                        // ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
