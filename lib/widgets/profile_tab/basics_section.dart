import 'package:flutter/material.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/edit_about_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/edit_education_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/occupation_screen.dart';
import 'package:getmarried/widgets/profile_tab/profile_list_tile.dart';

class BasicsSection extends StatefulWidget {
  const BasicsSection({Key? key, required this.user}) : super(key: key);
  final UserData user;

  @override
  State<BasicsSection> createState() => _BasicsSectionState();
}

class _BasicsSectionState extends State<BasicsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My basics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.account_balance_rounded,
              size: 20,
            ),
            tittle: 'Work',
            value: widget.user.occupations!.isNotEmpty
                ? widget.user.occupations![0]
                : null,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OccupationPage(),
              ));
            }),
        const SizedBox(
          height: 16,
        ),
        ProfileListTile(
            preffix: const Icon(
              Icons.school,
              size: 20,
            ),
            tittle: 'Education',
            value: widget.user.educationColledge!.isNotEmpty
                ? widget.user.educationColledge![0].toString()
                : null,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditEducationScreen(),
              ));
            }),
        const SizedBox(
          height: 16,
        ),
        // ProfileListTile(
        //     preffix: const Icon(
        //       Icons.shield_moon,
        //       size: 20,
        //     ),
        //     tittle: 'Covid dating',
        //     value: null,
        //     onTap: () {}),
        // const SizedBox(
        //   height: 16,
        // ),
        ProfileListTile(
            preffix: const Icon(
              Icons.person,
              size: 20,
            ),
            tittle: 'Gender',
            value: widget.user.gender,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    EditAboutScreen(options: ['Man', 'Woman'], field: 'gender'),
              ));
            }),
        const SizedBox(
          height: 16,
        ),
        // ProfileListTile(
        //     preffix: const Icon(
        //       Icons.location_on,
        //       size: 20,
        //     ),
        //     tittle: 'Location',
        //     value: null,
        //     onTap: () {}),
        // const SizedBox(
        //   height: 16,
        // ),
        // ProfileListTile(
        //     preffix: const Icon(
        //       Icons.home_filled,
        //       size: 20,
        //     ),
        //     tittle: 'Hometown',
        //     value: null,
        //     onTap: () {}),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
