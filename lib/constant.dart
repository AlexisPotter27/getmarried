import 'package:flutter/material.dart';
import 'models/chip_choice_mode.dart';

const Color primaryColour = Color(0xFF856DFD);
const Color ksecond = Color(0XFFf38321);

InputDecoration inputDecoration(BuildContext context) => InputDecoration(
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16.0,
      ),
      filled: true,
      counterStyle: const TextStyle(color: Colors.blueGrey),

      fillColor: Theme.of(context).cardColor,
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
  ChipChoiceModel(label: 'None', icon: Icons.sports_score),
];

List<ChipChoiceModel> goingOut = [
  ChipChoiceModel(label: 'Gigs', icon: Icons.celebration),
  ChipChoiceModel(label: 'Standup', icon: Icons.celebration),
  ChipChoiceModel(label: 'Festivals', icon: Icons.celebration),
  ChipChoiceModel(label: 'Meuseums & galleries', icon: Icons.celebration),
  ChipChoiceModel(label: 'Theatre', icon: Icons.celebration),
  ChipChoiceModel(label: 'Nightclubs', icon: Icons.celebration),
];
List<ChipChoiceModel> stayingIn = [
  ChipChoiceModel(label: 'Video Games', icon: Icons.celebration),
  ChipChoiceModel(label: 'Board Games', icon: Icons.celebration),
  ChipChoiceModel(label: 'Gardening', icon: Icons.celebration),
  ChipChoiceModel(label: 'Cooking', icon: Icons.celebration),
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
  'Sober',

];

List<String> smokeOptions = [
  'Socially',
  'Never',
  'Regularly',
];

List<String> havChildrenOptions = [
  'Want someday',
  'Dont want',
  'Have and want more',
  'Have and dont  want more',
  'Not sure yet',
];

List<String> religions = [
  'Agnostic',
  'Atheist',
  'Buddhist',
  'Catholic',
  'Christian',
  'Hindu',
  'Jain'
];

List<String> ploiticalLeanings = [
  'Agnostic',
  'Atheist',
  'Buddhist',
  'Catholic',
  'Christian',
  'Hindu',
  'Jain'
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