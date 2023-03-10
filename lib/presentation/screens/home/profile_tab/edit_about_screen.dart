import 'package:flutter/material.dart';

class EditAboutScreen extends StatefulWidget {
  const EditAboutScreen({Key? key}) : super(key: key);

  @override
  State<EditAboutScreen> createState() => _EditAboutScreenState();
}

class _EditAboutScreenState extends State<EditAboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
          ),
          SizedBox(height: 20,),
        Text('What is your height')
        ],
      ),
    );
  }
}
