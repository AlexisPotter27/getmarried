import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/chat/message_box.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        titleSpacing: 0,
        actions: const [_AppBarActionsWidget()],
        title: const _AppBarTittleWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => MessageBox(
                    isSender: (index == 1 || index == 3 || index == 5)),
              ),
            ),
            _InputBox()
          ],
        ),
      ),
    );
  }
}

class _AppBarTittleWidget extends StatelessWidget {
  const _AppBarTittleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(backgroundImage: AssetImage('assets/jpeg/person2.jpeg'),),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sebastian Rudger',
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
  const _InputBox({Key? key}) : super(key: key);

  @override
  State<_InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<_InputBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: inputDecoration(context).copyWith(
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.all(10),
          hintText: 'Type here...',
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,

            children: const [
            Icon(Icons.attach_file_rounded,color: Colors.grey,),
            SizedBox(width: 10,),
            Icon(Icons.photo_camera_outlined,color: Colors.grey),
          ],),
          hintStyle: const TextStyle(color: Colors.grey)),

    );
  }
}
