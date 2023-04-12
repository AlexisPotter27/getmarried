import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:getmarried/widgets/primary_button.dart';

class MatchedDialog extends StatefulWidget {
  const MatchedDialog(
      {Key? key, required this.swipedUser, required this.loggedInUser})
      : super(key: key);
  final UserData swipedUser;
  final UserData loggedInUser;

  @override
  State<MatchedDialog> createState() => _MatchedDialogState();
}

class _MatchedDialogState extends State<MatchedDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                CircleAvatar(
                    backgroundColor: primaryColour.withOpacity(0.2),
                    radius: 35,
                    child: Icon(
                      Icons.favorite,
                      size: 40,
                      color: primaryColour,
                    )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ImageCard(img: widget.swipedUser.photos![0]),
                      SizedBox(
                        width: 20,
                      ),
                      _ImageCard(img: widget.loggedInUser.photos![0]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Its a match, ${widget.loggedInUser.firstname}!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: primaryColour),
                ),
                Text(
                  'Start a conversation now with each other',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Start Conversation',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagingScreen(
                                  userData: widget.swipedUser.toChatUser()),
                            ));
                      }),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                      bgColor: primaryColour.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Continue swiping',
                          style: TextStyle(color: primaryColour),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    radius: 20,
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.red,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCard extends StatefulWidget {
  const _ImageCard({Key? key, required this.img}) : super(key: key);
  final String img;

  @override
  State<_ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<_ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                widget.img,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(16),
          color: primaryColour),
    );
  }
}
