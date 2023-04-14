import 'package:flutter/material.dart';
import 'package:getmarried/models/user.dart';

class UserChatItem extends StatefulWidget {
  const UserChatItem({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  State<UserChatItem> createState() => _UserChatItemState();
}

class _UserChatItemState extends State<UserChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.orange,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.userData.photos!.isNotEmpty ?widget.userData.photos![0]:''),
            ),
          ),
          // Text(widget.userData.firstname!)
        ],
      ),
    );
  }
}
