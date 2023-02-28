import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';

class ConversationItem extends StatefulWidget {
  const ConversationItem({Key? key}) : super(key: key);

  @override
  State<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MessagingScreen(),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: primaryColour,
              backgroundImage: AssetImage('assets/jpeg/person2.jpeg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Sebastian Rudger',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                    ),
                    Text(
                      '09:34 PM',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Perfect will check it',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: primaryColour,
                      radius: 10,
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
