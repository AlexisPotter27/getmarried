// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);
import 'dart:convert';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  final dynamic reporter;
  final dynamic victim;
  final String message;

  ReportModel({
    this.reporter,
    this.victim,
    required this.message,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    reporter: json["reporter"],
    victim: json["victim"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "reporter": reporter,
    "victim": victim,
    "message": message,
  };
}
