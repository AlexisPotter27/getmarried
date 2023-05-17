import 'package:flutter/material.dart';
import 'package:getmarried/admin/presentation/screens/reports_tab.dart';
import 'package:getmarried/admin/presentation/screens/users_tab.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:iconsax/iconsax.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var pages = [
    UsersTab(),
    ReportsTab(),
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedIconTheme: IconThemeData(color: primaryColour),
          selectedLabelStyle: TextStyle(color: primaryColour),
          selectedItemColor: primaryColour,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.profile_2user,
              ),
              label: 'User',
            ),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.warning_2), label: 'Reports'),
          ]),
    );
  }
}
