import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key, required this.userData, this.showButton = true})
      : super(key: key);
  final UserData userData;
  final bool? showButton;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  final AdminBloc bloc = AdminBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is UnblockUserSuccessState ||
            state is DisableUserSuccessState) {
          // getIt.get<AdminBloc>().add(GetReportsEvent());
          // getIt.get<AdminBloc>().add(GetUsersEvent());
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.userData.photos!.first),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userData.firstname!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.userData.gender!,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            widget.showButton!
                ? Row(
                    children: [
                      widget.userData.accountDisabled!
                          ? TextButton(
                              onPressed: () {
                                bloc.add(
                                    UnblockUserEvent(widget.userData.uid!));
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
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green),
                            )
                          : TextButton(
                              onPressed: () {
                                bloc.add(
                                    DisableUserEvent(widget.userData.uid!));
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
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColour),
                            ),
                      SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          bloc.add(DeleteUserEvent(widget.userData.uid!));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox()
          ],
        );
      },
    );
  }
}
