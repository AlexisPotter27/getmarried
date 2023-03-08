import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/widgets/chat/message_box.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key, this.conversationId, this.userData})
      : super(key: key);
  final String? conversationId;
  final ChatUser? userData;

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  ChatBloc chatBloc = ChatBloc(ChatRepositoryImpl());

  List<ChatMessage> messages = [];
  String? convoId;

  @override
  void initState() {
    convoId = widget.conversationId;

    if (convoId != null) {
      chatBloc.add(GetMessagesEvent(conversationId: convoId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        titleSpacing: 0,
        actions: const [_AppBarActionsWidget()],
        title: _AppBarTittleWidget(
          user: widget.userData!,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                bloc: chatBloc,
                listener: (context, state) {
                  if (state is MessagesFetchedState) {
                    setState(() {
                      messages = state.chatMessages;
                    });
                  }

                  if (state is StartConvoSuccesState) {
                    setState(() {
                      convoId = state.conversation.id;
                    });
                    log(state.conversation.id);
                  }
                },
                builder: (context, state) {
                  if (state is MessagesLoadingState) {
                    return Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => MessageBox(
                      message: messages[index],
                    ),
                  );
                },
              ),
            ),
            _InputBox(
              chatBloc,
              widget.userData,
              convoId: convoId,
              onMessageSent: (ChatMessage message) {
                setState(() {
                  messages.add(message);
                  log(message.text);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarTittleWidget extends StatefulWidget {
  const _AppBarTittleWidget({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<_AppBarTittleWidget> createState() => _AppBarTittleWidgetState();
}

class _AppBarTittleWidgetState extends State<_AppBarTittleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.user.photos[0]),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Text(
              'Online',
              style: TextStyle(fontSize: 13, color: primaryColour),
            ),
          ],
        )
      ],
    );
  }
}

class _AppBarActionsWidget extends StatelessWidget {
  const _AppBarActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call_outlined,
              color: Colors.grey.shade400,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: Colors.grey.shade400,
            )),
      ],
    );
  }
}

class _InputBox extends StatefulWidget {
  const _InputBox(this.chatBloc, this.userData,
      {Key? key, required this.convoId, required this.onMessageSent})
      : super(key: key);
  final ChatBloc chatBloc;
  final ChatUser? userData;
  final String? convoId;
  final Function(ChatMessage message) onMessageSent;

  @override
  State<_InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<_InputBox> {
  final controller = TextEditingController();
  UserData? cachedUser = getIt.get<CacheCubit>().user;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (val) {
        setState(() {});
      },
      decoration: inputDecoration(context).copyWith(
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.all(10),
          hintText: 'Type here...',
          suffixIcon: Visibility(
            visible: controller.text.isNotEmpty,
            child: GestureDetector(
              onTap: () {
                log(widget.convoId.toString());
                ChatMessage message = ChatMessage(
                    id: '',
                    senderId: cachedUser!.uid!,
                    text: controller.text,
                    timeSent: DateTime.now());
                widget.onMessageSent(message);

                if (widget.convoId == null) {
                  widget.chatBloc.add(StartConversationEvent(widget.userData!,
                      cachedUser!.toChatUser(), controller.text));
                  controller.clear();
                } else {
                  widget.chatBloc.add(SendMessageEvent(
                      message: message, conversationId: widget.convoId!));
                  controller.clear();
                }
              },
              child: CircleAvatar(
                backgroundColor: primaryColour,
                child: Center(
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
