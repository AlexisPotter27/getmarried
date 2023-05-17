import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/admin/data/models/get_reports_response.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/screens/report_details.dart';
import 'package:getmarried/admin/presentation/widgets/report_item.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/error_widget.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({Key? key}) : super(key: key);

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  // AdminBloc bloc = ge;
  List<Report> reports = [];

  @override
  void initState() {
    getIt.get<AdminBloc>().add(GetReportsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc:  getIt.get<AdminBloc>(),
        buildWhen: (prev, curr) =>
            curr is GetAllReportsFailureState ||
            curr is GetAllReportsLoadingState ||
            curr is GetAllReportsSuccessState ||
                curr is UnblockUserSuccessState ||
                curr is DisableUserSuccessState,
        listener: (context, state) {
          if (state is GetAllReportsSuccessState) {

            setState(() {
              reports = state.reports;
            });
          }
          if (state is GetAllReportsFailureState) {
            showCustomToast(state.error.toString());
          }

        },
        builder: (context, state) {
          if (state is GetAllReportsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColour,
              ),
            );
          }

          if (state is GetAllReportsFailureState) {
            return AppPromptWidget(
              canTryAgain: true,
              onTap: () {
                getIt.get<AdminBloc>().add(GetReportsEvent());
              },
            );
          }

          if (state is GetAllReportsSuccessState) {
            if (reports.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All  Reports',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportDetails(
                                      report: reports[index],
                                    ),
                                  ));
                            },
                            child: ReportItem(
                              report: reports[index],
                            )),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return AppPromptWidget(
                canTryAgain: true,
                message: 'There are no users yet',
                onTap: () {
                  getIt.get<AdminBloc>().add(GetReportsEvent());
                },
              );
            }
          }

          return SizedBox();
        },
      ),
    );
  }
}
