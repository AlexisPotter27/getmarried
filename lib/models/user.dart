import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{

  String uid;
  String name;
  int age;
  String dateOfBirth;
  String gender;
  String relationship_mode;
  String date_match;
  String email;
  String interests;
  String height;
  String workout;
  String star_sign;
  String education;
  String drinking;
  String smoking;
  String children;
  String religion;
  String political;
  String about;
  String phoneNumber;
  Timestamp accountCreated;

  OurUser(
    this.uid,
    this.name,
    this.age,
    this.dateOfBirth,
    this.gender,
    this.relationship_mode,
    this.date_match,
    this.email,
    this.interests,
    this.height,
    this.workout,
    this.star_sign,
    this.education,
    this.drinking,
    this.smoking,
    this.children,
    this.religion,
    this.political,
    this.about,
    this.phoneNumber,
    this.accountCreated
  );
}
