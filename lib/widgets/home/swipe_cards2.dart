import 'package:flutter/material.dart';

class SwipeCards2 extends StatefulWidget {
  const SwipeCards2({Key? key}) : super(key: key);

  @override
  State<SwipeCards2> createState() => _SwipeCards2State();
}

class _SwipeCards2State extends State<SwipeCards2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: const Center(
        child: Text('data'),
      ),
    );
  }
}
