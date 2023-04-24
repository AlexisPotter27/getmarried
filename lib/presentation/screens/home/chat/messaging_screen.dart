import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/widgets/chat/message_box.dart';
import 'package:getmarried/widgets/primary_button.dart';

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
  UserData cachedUser = getIt.get<CacheCubit>().user!;
  String? convoId;
  ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    convoId = widget.conversationId;

    if (convoId != null) {
      chatBloc.add(GetMessagesEvent(conversationId: convoId));
    } else {
      chatBloc.add(GetMessageWithIdEvent(
          user1: widget.userData!.id, user2: cachedUser.uid!));
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
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
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
                    return const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text('You have no messages here'),
                    );
                  }
                  return ListView.builder(
                    itemCount: messages.length,
                    controller: _scrollController,
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
                  // messages.add(message);
                  // log(message.text);
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
          backgroundImage: NetworkImage(
              widget.user.photos.isEmpty ? '' : widget.user.photos[0]),
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
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.video_call_outlined,
        //       color: Colors.grey.shade400,
        //     )),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.call,
        //       color: Colors.grey.shade400,
        //     )),
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ReportWidget(),
              );
            },
            icon: Icon(
              Icons.report,
              color: Colors.red,
            )),
        // TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       'Unmatched',
        //       style: TextStyle(color: Colors.orange),
        //     ))
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

class ReportWidget extends StatefulWidget {
  const ReportWidget({Key? key}) : super(key: key);

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text(
          //   'Report',
          //   style: TextStyle(
          //       fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          // ),
          Text(
            'Why do you wish to report this user. ?',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              maxLines: 4,
              textInputAction: TextInputAction.done,
              decoration: inputDecoration(context).copyWith(
                  fillColor: Colors.grey.shade300,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Reason for report.'),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          PrimaryButton(
            padding: EdgeInsets.all(18),
            onPressed: () {
              Navigator.pop(context);
              showCustomToast('Report sent');
            },
            child: Text(
              'Report',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
