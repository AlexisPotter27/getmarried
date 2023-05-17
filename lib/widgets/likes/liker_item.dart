import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:getmarried/presentation/screens/home/home_tab/user_details_screen.dart';

class LikerItem extends StatefulWidget {
  const LikerItem({Key? key, required this.userData}) : super(key: key);

  final UserData userData;

  @override
  State<LikerItem> createState() => _LikerItemState();
}

class _LikerItemState extends State<LikerItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsScreen(
                userId: widget.userData.uid!,
              ),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.userData.photos![0],
                  ),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 0,
              sigmaX: 0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    primaryColour.withOpacity(0.1),
                    primaryColour.withOpacity(0.2),
                    primaryColour.withOpacity(0.5),
                    primaryColour,
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          '${widget.userData.firstname!},',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.userData.age!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                        // Container(
                        //   // margin: const EdgeInsets.all(16),
                        //   height: 10,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       color: Colors.white),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            widget.userData.education ?? 'No education info',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // child: Image.asset('assets/jpeg/girl.jpeg'),
          ),
        ),
      ),
    );
  }
}
