// To parse this JSON data, do
//
//     final getReportsResponse = getReportsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:getmarried/models/user.dart';

GetReportsResponse getReportsResponseFromJson(String str) => GetReportsResponse.fromJson(json.decode(str));

String getReportsResponseToJson(GetReportsResponse data) => json.encode(data.toJson());

class GetReportsResponse {
  final List<Report> reports;

  GetReportsResponse({
    required this.reports,
  });

  factory GetReportsResponse.fromJson(Map<String, dynamic> json) => GetReportsResponse(
    reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
  };
}

class Report {
  final UserData victim;
  final UserData reporter;
  final String message;

  Report({
    required this.victim,
    required this.reporter,
    required this.message,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    victim: UserData.fromJson(json["victim"]),
    reporter: UserData.fromJson(json["reporter"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "victim": victim.toJson(),
    "reporter": reporter.toJson(),
    "message": message,
  };
}

