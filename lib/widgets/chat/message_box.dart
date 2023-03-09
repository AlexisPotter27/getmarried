import 'package:flutter/material.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/chat/receiver_message_item.dart';
import 'package:getmarried/widgets/chat/sender_message_item.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key, required this.message}) : super(key: key);
  final ChatMessage message;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  UserData cachedUser = getIt.get<CacheCubit>().user!;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: isSender
          ? SenderMessageItem(
              message: widget.message,
            )
          : ReceiverMessageItem(
              message: widget.message,
            ),
    );
  }

  bool get isSender => widget.message.senderId == cachedUser.uid;
}
