import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/white_textfield.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final institutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: canUpdate ? () {} : null,
              icon: Icon(
                Icons.check,
                color: canUpdate ? primaryColour : Colors.grey,
              ))
        ],
        title: Text('Add education'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          WhiteTextField(
            hint: 'Institution',
            controller: institutionController,
            onChanged: (val) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text('Graduation year'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get canUpdate => institutionController.text.isNotEmpty;
}
