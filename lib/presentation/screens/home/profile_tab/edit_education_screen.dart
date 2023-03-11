import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/add_job_screen.dart';

import 'occupation_screen.dart';

class EditEducationScreen extends StatefulWidget {
  const EditEducationScreen({Key? key}) : super(key: key);

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text('Education'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'You can only show one institution on your profile at a time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddJobScreen(),
              ));
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text('Add education'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) => BasicDetailItem(),
          )
        ],
      ),
    );
  }
}
