import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/white_textfield.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final tittleController = TextEditingController();
  final companyController = TextEditingController();

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
        title: Text('Add job'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          WhiteTextField(
            hint: 'Tittle',
            controller: tittleController,
            onChanged: (val){
              setState(() {

              });
            },
          ),
          SizedBox(
            height: 2,
          ),
          WhiteTextField(
            hint: 'Company (or just industry)',
            controller: companyController,
          ),
        ],
      ),
    );
  }

  bool get canUpdate => tittleController.text.isNotEmpty;
}
