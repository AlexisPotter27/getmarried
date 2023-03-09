import 'package:flutter/material.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/widgets/profile_tab/profile_list_tile.dart';

class MoreAboutSection extends StatefulWidget {
  const MoreAboutSection({Key? key, required this.user}) : super(key: key);
  final UserData user;

  @override
  State<MoreAboutSection> createState() => _MoreAboutSectionState();
}

class _MoreAboutSectionState extends State<MoreAboutSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'More about me',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Cover things most people are curious about.',
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.straighten,
              size: 20,
            ),
            tittle: 'Height',
            value: widget.user.height,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.fitness_center,
              size: 20,
            ),
            tittle: 'Exercise',
            value: null,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.school_outlined,
              size: 20,
            ),
            tittle: 'Education level',
            value: widget.user.education,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.wine_bar_outlined,
              size: 20,
            ),
            tittle: 'Drinking ',
            value: widget.user.drinking,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.smoking_rooms,
              size: 20,
            ),
            tittle: 'Smoking',
            value: widget.user.smoking,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.search,
              size: 20,
            ),
            tittle: 'Looking for',
            value: widget.user.lookingFor,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.takeout_dining_outlined,
              size: 20,
            ),
            tittle: 'Kids',
            value: widget.user.children,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.star_border_purple500,
              size: 20,
            ),
            tittle: 'Start sign',
            value: widget.user.starSign,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.account_balance,
              size: 20,
            ),
            tittle: 'Politics',
            value: widget.user.political,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.waving_hand_outlined,
              size: 20,
            ),
            tittle: 'Religion',
            value: widget.user.religion,
            onTap: () {}),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
