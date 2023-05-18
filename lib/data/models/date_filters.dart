// To parse this JSON data, do
//
//     final dateFilters = dateFiltersFromJson(jsonString);

import 'dart:convert';

DateFilters dateFiltersFromJson(String str) => DateFilters.fromJson(json.decode(str));

String dateFiltersToJson(DateFilters data) => json.encode(data.toJson());

class DateFilters {
  DateFilters({
    this.date,
    this.age,
    this.langiages,
    this.verifiedOnly = false,
    this.height,
    this.excercise,
    this.education,
    this.drink,
    this.smoke,
    this.children,
    this.lookingFor,
    this.startSign,
    this.topics,
    this.religion,
  });

  String? date;
  String? age;
  List<String>? langiages;
  bool? verifiedOnly;
  String? height;
  String? excercise;
  String? education;
  String? drink;
  String? smoke;
  String? children;
  String? lookingFor;
  String? startSign;
  String? topics;
  String? religion;

  DateFilters copyWith({
    String? date,
    String? age,
    List<String>? langiages,
    bool? verifiedOnly,
    String? height,
    String? excercise,
    String? education,
    String? drink,
    String? smoke,
    String? children,
    String? lookingFor,
    String? startSign,
    String? topics,
    String? religion,
  }) =>
      DateFilters(
        date: date ?? this.date,
        age: age ?? this.age,
        langiages: langiages ?? this.langiages,
        verifiedOnly: verifiedOnly ?? this.verifiedOnly,
        height: height ?? this.height,
        excercise: excercise ?? this.excercise,
        education: education ?? this.education,
        drink: drink ?? this.drink,
        smoke: smoke ?? this.smoke,
        children: children ?? this.children,
        lookingFor: lookingFor ?? this.lookingFor,
        startSign: startSign ?? this.startSign,
        topics: topics ?? this.topics,
        religion: religion ?? this.religion,
      );

  factory DateFilters.fromJson(Map<String, dynamic> json) => DateFilters(
    date: json["date"],
    age: json["age"],
    langiages: json["langiages"] == null ? [] : List<String>.from(json["langiages"]!.map((x) => x)),
    verifiedOnly: json["verified_only"],
    height: json["height"],
    excercise: json["excercise"],
    education: json["education"],
    drink: json["drink"],
    smoke: json["smoke"],
    children: json["children"],
    lookingFor: json["looking_for"],
    startSign: json["start_sign"],
    topics: json["topics"],
    religion: json["religion"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "age": age,
    "langiages": langiages == null ? [] : List<dynamic>.from(langiages!.map((x) => x)),
    "verified_only": verifiedOnly,
    "height": height,
    "excercise": excercise,
    "education": education,
    "drink": drink,
    "smoke": smoke,
    "children": children,
    "looking_for": lookingFor,
    "start_sign": startSign,
    "topics": topics,
    "religion": religion,
  };
}
