import 'package:flutter/material.dart';
import 'package:getmarried/admin/data/models/get_reports_response.dart';

class ReportItem extends StatefulWidget {
  const ReportItem({Key? key, required this.report}) : super(key: key);
  final Report report;

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 25,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.report.reporter.firstname!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                    widget.report.message,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Text(
          //   '24th May 2020',
          //   style: TextStyle(fontSize: 13,color: Colors.grey),
          // ),
        ],
      ),
    );
  }
}
