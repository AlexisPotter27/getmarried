// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);
import 'dart:convert';
import 'dart:developer';

import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/models/date_filters.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.uid,
    this.firstname,
    this.age,
    this.dateOfBirth,
    this.gender,
    this.relationshipMode,
    this.dateMatch,
    this.email,
    this.interests,
    this.height,
    this.workout,
    this.starSign,
    this.education,
    this.drinking,
    this.smoking,
    this.children,
    this.religion,
    this.political,
    this.about,
    this.phoneNumber,
    this.idealPartnerHeight,
    this.acceptedPrivacy,
    this.accountCreated,
    this.lookingFor,
    this.bodyType,
    this.partnerBodyType,
    this.partnerAttractiveness,
    this.drugs,
    this.partnerReligion,
    this.ethnicity,
    this.partnerEthnicity,
    this.potentialEvent,
    this.understanding,
    this.outgoing,
    this.ambitious,
    this.athletic,
    this.startingAndFinishing,
    this.sexInRelationship,
    this.monogamy,
    this.creativity,
    this.moreAbout,
    this.policyAgreed,
    this.regStatus,
    this.photos,
    this.occupations,
    this.educationColledge,
    this.languages,
    this.dateFilters,
    this.location,
    this.likes,
    this.likeMe,
    this.dislikes,
    this.matches,
    this.deviceId,
    this.accountDisabled,
  });

  String? uid;
  String? deviceId;
  String? firstname;
  bool? accountDisabled;
  String? age;
  String? dateOfBirth;
  String? gender;
  String? relationshipMode;
  String? dateMatch;
  String? email;
  List<dynamic>? interests;
  String? height;
  String? workout;
  String? starSign;
  String? education;
  String? drinking;
  String? smoking;
  String? children;
  String? religion;
  String? political;
  String? about;
  String? phoneNumber;
  String? idealPartnerHeight;
  bool? acceptedPrivacy;
  String? accountCreated;
  String? lookingFor;
  String? bodyType;
  String? partnerBodyType;
  String? partnerAttractiveness;
  String? drugs;
  String? partnerReligion;
  String? ethnicity;
  String? partnerEthnicity;
  String? potentialEvent;
  String? understanding;
  String? outgoing;
  String? ambitious;
  String? athletic;
  String? startingAndFinishing;
  String? sexInRelationship;
  String? monogamy;
  String? creativity;
  String? moreAbout;
  bool? policyAgreed;
  int? regStatus;
  DateFilters? dateFilters;
  List<dynamic>? photos;
  List<dynamic>? occupations;
  List<dynamic>? educationColledge;
  List<String>? languages;
  String? location;
  List<dynamic>? likes;
  List<dynamic>? likeMe;
  List<dynamic>? dislikes;
  List<dynamic>? matches;

  UserData copyWith(
          {String? uid,
          String? firstname,
          String? age,
          String? dateOfBirth,
          String? gender,
          String? relationshipMode,
          String? dateMatch,
          String? email,
          List<dynamic>? interests,
          String? height,
          String? workout,
          String? starSign,
          String? education,
          String? drinking,
          String? smoking,
          String? children,
          String? religion,
          String? political,
          String? about,
          String? phoneNumber,
          String? idealPartnerHeight,
          bool? acceptedPrivacy,
          String? accountCreated,
          String? lookingFor,
          String? bodyType,
          String? partnerBodyType,
          String? partnerAttractiveness,
          String? drugs,
          String? partnerReligion,
          String? ethnicity,
          String? partnerEthnicity,
          String? potentialEvent,
          String? understanding,
          String? outgoing,
          String? ambitious,
          String? athletic,
          String? startingAndFinishing,
          String? sexInRelationship,
          String? monogamy,
          String? creativity,
          String? deviceId,
          bool? policyAgreed,
          int? regStatus,
          DateFilters? dateFilters,
          List<dynamic>? photos,
          List<dynamic>? occupations,
          List<dynamic>? educationColledge,
          List<String>? languages,
          String? location,
          List<dynamic>? likes,
          List<dynamic>? dislikes,
          bool? accountDisabled,
          List<dynamic>? likeMe}) =>
      UserData(
        uid: uid ?? this.uid,
        firstname: firstname ?? this.firstname,
        age: age ?? this.age,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        relationshipMode: relationshipMode ?? this.relationshipMode,
        dateMatch: dateMatch ?? this.dateMatch,
        email: email ?? this.email,
        interests: interests ?? this.interests,
        height: height ?? this.height,
        workout: workout ?? this.workout,
        starSign: starSign ?? this.starSign,
        education: education ?? this.education,
        drinking: drinking ?? this.drinking,
        smoking: smoking ?? this.smoking,
        children: children ?? this.children,
        religion: religion ?? this.religion,
        political: political ?? this.political,
        about: about ?? this.about,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        idealPartnerHeight: idealPartnerHeight ?? this.idealPartnerHeight,
        acceptedPrivacy: acceptedPrivacy ?? this.acceptedPrivacy,
        accountCreated: accountCreated ?? this.accountCreated,
        lookingFor: lookingFor ?? this.lookingFor,
        bodyType: bodyType ?? this.bodyType,
        partnerBodyType: partnerBodyType ?? this.partnerBodyType,
        partnerAttractiveness:
            partnerAttractiveness ?? this.partnerAttractiveness,
        drugs: drugs ?? this.drugs,
        partnerReligion: partnerReligion ?? this.partnerReligion,
        ethnicity: ethnicity ?? this.ethnicity,
        partnerEthnicity: partnerEthnicity ?? this.partnerEthnicity,
        potentialEvent: potentialEvent ?? this.potentialEvent,
        understanding: understanding ?? this.understanding,
        outgoing: outgoing ?? this.outgoing,
        ambitious: ambitious ?? this.ambitious,
        athletic: athletic ?? this.athletic,
        startingAndFinishing: startingAndFinishing ?? this.startingAndFinishing,
        sexInRelationship: sexInRelationship ?? this.sexInRelationship,
        monogamy: monogamy ?? this.monogamy,
        creativity: creativity ?? this.creativity,
        moreAbout: moreAbout ?? this.moreAbout,
        policyAgreed: policyAgreed ?? this.policyAgreed,
        regStatus: regStatus ?? this.regStatus,
        photos: photos ?? this.photos,
        occupations: occupations ?? this.occupations,
        educationColledge: educationColledge ?? this.educationColledge,
        languages: languages ?? this.languages,
        dateFilters: dateFilters ?? this.dateFilters,
        location: location ?? this.location,
        deviceId: deviceId ?? this.deviceId,
        likes: likes ?? this.likes,
        likeMe: likeMe ?? this.likeMe,
        dislikes: dislikes ?? this.dislikes,
        matches: matches ?? this.matches,
        accountDisabled: accountDisabled ?? this.accountDisabled,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        firstname: json["firstname"],
        age: json["age"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        relationshipMode: json["relationship_mode"],
        dateMatch: json["date_match"],
        email: json["email"],
        interests: json["interests"] == null
            ? []
            : List<dynamic>.from(json["interests"]!.map((x) => x)),
        height: json["height"]?.toDouble(),
        workout: json["workout"],
        starSign: json["star_sign"],
        education: json["education"],
        drinking: json["drinking"],
        smoking: json["smoking"],
        children: json["children"],
        religion: json["religion"],
        political: json["political"],
        about: json["about"],
        phoneNumber: json["phoneNumber"],
        idealPartnerHeight: json["ideal_partner_height"],
        acceptedPrivacy: json["accepted_privacy"],
        accountCreated: json["account_created"],
        lookingFor: json["looking_for"],
        bodyType: json["body_type"],
        partnerBodyType: json["partner_body_type"],
        partnerAttractiveness: json["partner_attractiveness"],
        drugs: json["drugs"],
        partnerReligion: json["partner_religion"],
        ethnicity: json["ethnicity"],
        partnerEthnicity: json["partner_ethnicity"],
        potentialEvent: json["potential_event"],
        understanding: json["understanding"],
        outgoing: json["outgoing"],
        ambitious: json["ambitious"],
        athletic: json["athletic"],
        startingAndFinishing: json["starting_and_finishing"],
        sexInRelationship: json["sex_in_relationship"],
        monogamy: json["monogamy"],
        creativity: json["creativity"],
        moreAbout: json["more_about"],
        policyAgreed: json["policy_agreed"],
        regStatus: json["reg_status"],
        deviceId: json["device_id"],
        accountDisabled: json["account_disabled"] ?? false,
        dateFilters: json["date_filters"] == null
            ? null
            : DateFilters.fromJson(json['date_filters']),
        photos: json["photos"] == null
            ? []
            : List<dynamic>.from(json["photos"]!.map((x) => x)),
        occupations: json["occupations"] == null
            ? []
            : List<dynamic>.from(json["occupations"]!.map((x) => x)),
        educationColledge: json["educationColledge"] == null
            ? []
            : List<dynamic>.from(json["educationColledge"]!.map((x) => x)),
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        likes: json["likes"] == null
            ? []
            : List<dynamic>.from(json["likes"]!.map((x) => x)),
        likeMe: json["like_me"] == null
            ? []
            : List<dynamic>.from(json["like_me"]!.map((x) => x)),
        dislikes: json["dislikes"] == null
            ? []
            : List<dynamic>.from(json["dislikes"]!.map((x) => x)),
        matches: json["matches"] == null
            ? []
            : List<dynamic>.from(json["matches"]!.map((x) => x)),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstname,
        "age": age,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "relationship_mode": relationshipMode,
        "date_match": dateMatch,
        "email": email,
        "interests": interests == null
            ? []
            : List<dynamic>.from(interests!.map((x) => x)),
        "height": height,
        "workout": workout,
        "star_sign": starSign,
        "education": education,
        "drinking": drinking,
        "smoking": smoking,
        "children": children,
        "religion": religion,
        "political": political,
        "about": about,
        "phoneNumber": phoneNumber,
        "ideal_partner_height": idealPartnerHeight,
        "accepted_privacy": acceptedPrivacy,
        "account_created": accountCreated,
        "looking_for": lookingFor,
        "body_type": bodyType,
        "partner_body_type": partnerBodyType,
        "partner_attractiveness": partnerAttractiveness,
        "drugs": drugs,
        "partner_religion": partnerReligion,
        "ethnicity": ethnicity,
        "partner_ethnicity": partnerEthnicity,
        "potential_event": potentialEvent,
        "understanding": understanding,
        "outgoing": outgoing,
        "ambitious": ambitious,
        "athletic": athletic,
        "starting_and_finishing": startingAndFinishing,
        "sex_in_relationship": sexInRelationship,
        "monogamy": monogamy,
        "creativity": creativity,
        "more_about": moreAbout,
        "policy_agreed": policyAgreed,
        "reg_status": regStatus,
        "account_disabled": accountDisabled,
        "date_filters": dateFilters?.toJson(),
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "occupations": occupations == null
            ? []
            : List<dynamic>.from(occupations!.map((x) => x)),
        "educationColledge": educationColledge == null
            ? []
            : List<dynamic>.from(educationColledge!.map((x) => x)),
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
        "like_me":
            likeMe == null ? [] : List<dynamic>.from(likeMe!.map((x) => x)),
        "dislikes":
            dislikes == null ? [] : List<dynamic>.from(dislikes!.map((x) => x)),
        "matches":
            matches == null ? [] : List<dynamic>.from(matches!.map((x) => x)),
        "location": location,
        "device_id": deviceId,
      };

  ChatUser toChatUser() => ChatUser(
      id: this.uid!,
      name: this.firstname!,
      photos: this.photos!,
      about: this.about ?? '');

  static generateData() {}

  int getPercentage() {
    List all = [
      firstname,
      // height,
      // drugs,
      drinking,
      age,
      about,
      // ambitious,
      // athletic,
      acceptedPrivacy,
      accountCreated,
      // bodyType,
      // children,
      education,
      email,
      gender,
      height,
      about,
      lookingFor,
      languages,
      photos,
      // occupations,
      // outgoing,
      // phoneNumber,
      political,
      religion,
      smoking,
      starSign,
      // workout,
    ];

    int completed = all.where((element) => element != null).toList().length;

    log("Completed${completed.toString()}");
    log("All${all.length.toString()}");

    int percentage = ((completed / all.length) * 100).round();

    return percentage;
  }
}
