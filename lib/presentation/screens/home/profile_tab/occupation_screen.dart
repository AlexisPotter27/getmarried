import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/add_job_screen.dart';

class OccupationPage extends StatefulWidget {
  const OccupationPage({Key? key}) : super(key: key);

  @override
  State<OccupationPage> createState() => _OccupationPageState();
}

class _OccupationPageState extends State<OccupationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text('Occupation'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'You can only add one job on your profile at a time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
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
                    child: Text('Add a job'),
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

class BasicDetailItem extends StatefulWidget {
  const BasicDetailItem({Key? key}) : super(key: key);

  @override
  State<BasicDetailItem> createState() => _BasicDetailItemState();
}

class _BasicDetailItemState extends State<BasicDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          children: [
            Icon(
              Icons.check_box,
              color: primaryColour,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(child: Text('Software developer')),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey.shade400,
                ))
          ],
        ),
      ),
    );
  }
}
