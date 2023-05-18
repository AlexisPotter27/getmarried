import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/data/models/get_reports_response.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/screens/user_details_screen.dart';
import 'package:getmarried/admin/presentation/widgets/user_item.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({Key? key, required this.report}) : super(key: key);
  final Report report;

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  _ReportDetailsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: getIt.get<AdminBloc>(),
        listener: (context, state) {
          if (state is UnblockUserSuccessState ||
              state is DisableUserSuccessState) {
            showCustomToast('Done');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Message',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    widget.report.message,
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Reporter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(
                              userData: widget.report.reporter,
                            ),
                          ));
                    },
                    child: UserItem(userData: widget.report.reporter,showButton: false,)),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Reported User',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(
                              userData: widget.report.victim,
                            ),
                          ));
                    },
                    child: UserItem(userData: widget.report.victim,showButton: false,))
              ],
            ),
          );
        },
      ),
    );
  }
}
