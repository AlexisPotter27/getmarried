import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/data/models/report.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository_impl.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/blocs/chat/chat_bloc.dart';
import 'package:getmarried/presentation/blocs/matching/matching_bloc.dart';
import 'package:getmarried/presentation/screens/home/home_tab/user_details_screen.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();

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
        actions: [
          _AppBarActionsWidget(
            user: widget.userData!,
          )
        ],
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
                listener: (context, state) async {
                  if (state is MessagesFetchedState) {
                    setState(() {
                      messages = state.chatMessages.reversed.toList();
                    });

                    // await Future.delayed(Duration(milliseconds: 1)).then((value) => _scrollDown());
                  }

                  if (state is StartConvoSuccesState) {
                    setState(() {
                      convoId = state.conversation.id;
                    });
                    _scrollDown();
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
                    shrinkWrap: true,
                    reverse: true,
                    restorationId: 'a',
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

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0,
          duration: Duration(microseconds: 1), curve: Curves.ease);
    }
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
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                      userId: widget.user.id, showMesageButton: false),
                ));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                widget.user.photos.isEmpty ? '' : widget.user.photos[0]),
          ),
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
  const _AppBarActionsWidget({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

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
                builder: (context) => ReportWidget(
                  user: user,
                ),
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
  ReportWidget({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  var _formKey = GlobalKey<FormState>();
  var _controller = TextEditingController();
  final MatchingBloc bloc = MatchingBloc(getIt.get());
  final userData = getIt.get<CacheCubit>().user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Form(
        key: _formKey,
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
              child: TextFormField(
                maxLines: 4,
                validator: (val) {
                  if (val == null) {
                    return 'Enter reason';
                  }
                  return null;
                },
                controller: _controller,
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
                if (_formKey.currentState!.validate()) {
                  bloc.add(SendReportEvent(ReportModel(
                      message: _controller.text,
                      reporter: widget.user.id,
                      victim: userData!.uid)));
                }
                // Navigator.pop(context);
                // showCustomToast('Report sent');
              },
              child: BlocConsumer<MatchingBloc, MatchingState>(
                bloc: bloc,
                listener: _listenToMatchingBloc,
                builder: (context, state) {
                  return state is SendReportLoadingState
                      ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 3,))
                      : Text(
                          'Report',
                          style: TextStyle(color: Colors.white),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _listenToMatchingBloc(BuildContext context, MatchingState state) {
    if (state is SendReportSuccessState) {
      Navigator.pop(context);
      showCustomToast('Report sent', Colors.green);
    }
    if (state is SendReportFailureState) {
      Navigator.pop(context);
      showCustomToast(state.error, Colors.red);
    }
  }
}
