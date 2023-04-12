import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatefulWidget {
  const ConversationItem({Key? key, required this.conversation})
      : super(key: key);
  final Conversation conversation;

  @override
  State<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  UserData cacheUser = getIt.get<CacheCubit>().user!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MessagingScreen(
              conversationId: widget.conversation.id, userData: otherUser()),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: primaryColour,
              backgroundImage: NetworkImage(otherUser().photos[0]),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        otherUser().name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                    ),
                    Text(
                      DateFormat.jms()
                          .format(widget.conversation.lastMessage.timeSent),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.conversation.lastMessage.text,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: primaryColour,
                    //   radius: 10,
                    //   child: Center(
                    //     child: Text(
                    //       '2',
                    //       style: TextStyle(fontSize: 13),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  ChatUser otherUser() {
    if (widget.conversation.user1.id == cacheUser.uid) {
      return widget.conversation.user2;
    } else {
      return widget.conversation.user1;
    }
  }
}
