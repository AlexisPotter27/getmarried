import 'package:flutter/material.dart';
import 'package:getmarried/data/models/chip_choice_mode.dart';
import 'package:getmarried/data/models/feature_model.dart';

// const Color primaryColour = Color(0xFF856DFD);
const Color primaryColour = Colors.indigoAccent;
const Color ksecond = Color(0XFFf38321);

InputDecoration inputDecoration(BuildContext context) =>
    InputDecoration(
      hintStyle: TextStyle(
        color: Theme
            .of(context)
            .colorScheme
            .onPrimary,
        fontSize: 16.0,
      ),
      filled: true,
      counterStyle: const TextStyle(color: Colors.blueGrey),

      fillColor: Theme
          .of(context)
          .cardColor,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0)),
// enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//     borderSide: BorderSide(
//       color: Theme.of(context).colorScheme.secondary,
//     )),
// focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//     borderSide: BorderSide(
//       color: Theme.of(context).colorScheme.secondary,
//     )),
// border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//     borderSide: BorderSide(
//       color: Theme.of(context).colorScheme.secondary,
// )
// )
    );


List<ChipChoiceModel> creativityChoices = [
  ChipChoiceModel(label: 'Art', icon: Icons.emoji_objects),
  ChipChoiceModel(label: 'Design', icon: Icons.emoji_objects),
  ChipChoiceModel(label: 'Photography', icon: Icons.emoji_objects),
  ChipChoiceModel(label: 'Writing', icon: Icons.emoji_objects),
  ChipChoiceModel(label: 'Singing', icon: Icons.emoji_objects),
  ChipChoiceModel(label: 'Craft', icon: Icons.emoji_objects),
];


List<ChipChoiceModel> sports = [
  ChipChoiceModel(label: 'Yoga', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Running', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Cricket', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Football', icon: Icons.sports_score),
  ChipChoiceModel(label: 'BasketBall', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Soccer', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Volleyball', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Weights', icon: Icons.sports_score),
  ChipChoiceModel(label: 'Swimming', icon: Icons.sports_score),
  ChipChoiceModel(label: 'None', icon: Icons.sports_score),
];

List<ChipChoiceModel> goingOut = [
  ChipChoiceModel(label: 'Gigs', icon: Icons.celebration),
  ChipChoiceModel(label: 'Restaurants', icon: Icons.celebration),
  ChipChoiceModel(label: 'Theatre', icon: Icons.celebration),
  ChipChoiceModel(label: 'Museums & galleries', icon: Icons.celebration),
  ChipChoiceModel(label: 'Movies', icon: Icons.celebration),
  ChipChoiceModel(label: 'Nightclubs', icon: Icons.celebration),
  ChipChoiceModel(label: 'Drinks', icon: Icons.celebration),
  ChipChoiceModel(label: 'Dancing', icon: Icons.celebration),
];
List<ChipChoiceModel> stayingIn = [
  ChipChoiceModel(label: 'Video Games', icon: Icons.celebration),
  ChipChoiceModel(label: 'Board Games', icon: Icons.celebration),
  ChipChoiceModel(label: 'Tv', icon: Icons.celebration),
  ChipChoiceModel(label: 'Movies', icon: Icons.celebration),
  ChipChoiceModel(label: 'Gardening', icon: Icons.celebration),
  ChipChoiceModel(label: 'Cooking', icon: Icons.celebration),
  ChipChoiceModel(label: 'Exercising ', icon: Icons.celebration),
  ChipChoiceModel(label: 'Reading', icon: Icons.celebration),
  ChipChoiceModel(label: 'Baking', icon: Icons.celebration),
  ChipChoiceModel(label: 'Take ways', icon: Icons.celebration),
];

List<ChipChoiceModel> filmTv = [
  ChipChoiceModel(label: 'Romance', icon: Icons.tv),
  ChipChoiceModel(label: 'Comedy', icon: Icons.tv),
  ChipChoiceModel(label: 'Horror', icon: Icons.tv),
  ChipChoiceModel(label: 'Thriller', icon: Icons.tv),
  ChipChoiceModel(label: 'Fantasy', icon: Icons.tv),
  ChipChoiceModel(label: 'Sci fi', icon: Icons.tv),
  ChipChoiceModel(label: 'Anime', icon: Icons.tv),
];

List<String> starSigns = [
  'Aries',
  'Taurus',
  'Gemini',
  'Cancer',
  'Leo',
  'Virgo',
  'Libra',
  'Scorpio',
  'Sagittarius',
  'Capricorn',
  'Aquarius',
  'Pisces',
];

List<String> ethnic = [
  'White or Caucasian',
  'Native American Indian or Native Alaskan',
  'Asian',
  'Native Hawaiian or Pacific',
  'Black or African-American',
  'Latino or Hispanic',
  'Middle Eastern',
  'Other',
];

List<String> educations = [
  'High school',
  'Trade/tech school',
  'In college',
  'Undergraduate degree',
  'In grad school',
  'Graduate degree',
];

List<String> drinkingOptions = [
  'Frequently',
  'Socially',
  'Rarely',
  'Never',
];

List<String> smokeOptions = [
  'Socially',
  'Never',
  'Regularly',
];

List<String> drugsOptions = [
  'Never',
  'Socially',
  'Regularly',
];

List<String> havChildrenOptions = [
  "Want someday",
  "Don't want",
  'Have and want more',
  "Have and don't want more",
  'Not sure yet',
];

List<String> religions = [
  'Agnostic',
  'Atheist',
  'Buddhist',
  'Catholic',
  'Christian',
  'Hindu',
  'Jewish',
  'Other'
];

List<String> partnersReligions = [
  'Agnostic',
  'Atheist',
  'Buddhist',
  'Catholic',
  'Christian',
  'Hindu',
  'Jewish',
  'Other',
  "I don't mind",
];

List<String> ploiticalLeanings = [
  'Apolitical',
  'Moderate',
  'Liberal',
  'Conservative',
];

List<String> maleGenders = [
  'Inter sex',
  'Trans man ',
  'Trans masculine',
  'Man and Nonbinary',
  'Cis man'
];
List<String> femaleGenders = [
  'Intersex woman',
  'Trans woman ',
  'Transfemine',
  'Woman and Nonbinary',
  'Cis woman'
];
List<String> nonBinaryGenders = [
  'Agender',
  'Bigender ',
  'Genderfluid',
  'Genderqueer',
  'Gender questioning'
      'Neutrois'
      'Nonbinary man'
];

List<FeatureModel> features = [
  FeatureModel(
      feature: 'Unlimited', description: '', plans: ['premium', 'boost']),
  FeatureModel(feature: 'Beeline', description: '', plans: [
    'premium',
  ]),
  FeatureModel(feature: 'Advanced filters', description: '', plans: [
    'premium',
  ]),
  FeatureModel(feature: 'Incognito mode', description: '', plans: [
    'premium',
  ]),
  FeatureModel(feature: 'Travel mode', description: '', plans: [
    'premium',
  ]),
  FeatureModel(
      feature: '5 SuperWipes a week',
      description: '',
      plans: ['premium', 'boost']),
  FeatureModel(
      feature: '1 Spotlight a week',
      description: '',
      plans: ['premium', 'boost']),
  FeatureModel(
      feature: 'Unlimited Extends',
      description: '',
      plans: ['premium', 'boost']),
  FeatureModel(
      feature: 'Unlimited Rematch',
      description: '',
      plans: ['premium', 'boost']),
  FeatureModel(
      feature: 'Unlimited Backtrack',
      description: '',
      plans: ['premium', 'boost']),
];

List<String> languages = [
  'English',
  'Spanish',
  'Arabic',
  'German',
  'Deutsch',
  'Portuguese',
  'Greek',
  'Hebrew',
  'Italian',
  'Japanese',
  'Russian',
  'Swedish',
  'Taiwanese'
  'Turkish'
];

List<ChipChoiceModel> myLanguage = [
ChipChoiceModel(label: 'English', icon: Icons.language),
ChipChoiceModel(label: 'Igbo', icon: Icons.emoji_objects),
ChipChoiceModel(label: 'Spanish', icon: Icons.emoji_objects),

];



Size getDeviceSize({BuildContext? context}) =>
    WidgetsBinding.instance.window.physicalSize.flipped;

double deviceWidth() =>
    WidgetsBinding.instance.window.physicalSize.width /
    WidgetsBinding.instance.window.devicePixelRatio;