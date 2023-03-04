// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);
import 'dart:convert';

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
  });

  String? uid;
  String? firstname;
  String? age;
  String? dateOfBirth;
  String? gender;
  String? relationshipMode;
  String? dateMatch;
  String? email;
  List<dynamic>? interests;
  double? height;
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
  List<dynamic>? photos;

  UserData copyWith({
    String? uid,
    String? firstname,
    String? age,
    String? dateOfBirth,
    String? gender,
    String? relationshipMode,
    String? dateMatch,
    String? email,
    List<dynamic>? interests,
    double? height,
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
    String? moreAbout,
    bool? policyAgreed,
    int? regStatus,
    List<dynamic>? photos,
  }) =>
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
        partnerAttractiveness: partnerAttractiveness ?? this.partnerAttractiveness,
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
    interests: json["interests"] == null ? [] : List<dynamic>.from(json["interests"]!.map((x) => x)),
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
    photos: json["photos"] == null ? [] : List<dynamic>.from(json["photos"]!.map((x) => x)),
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
    "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
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
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
  };
}
