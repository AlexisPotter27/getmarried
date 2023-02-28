import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/chat/conversation_item.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: inputDecoration(context).copyWith(
                          fillColor: Colors.grey.shade200,
                          hintText: 'Search message',
                          prefixIcon: const Icon(Icons.search,),
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.edit_note_outlined,size: 30,color: Colors.grey,),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const ConversationItem(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
