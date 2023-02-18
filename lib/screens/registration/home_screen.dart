import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      size: 25,
                    )),
                const Expanded(
                    child: Text(
                  'GetMarriedApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      size: 25,
                    )),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedIconTheme: const IconThemeData(color: Colors.grey,size: 25),
          selectedIconTheme: const IconThemeData(color: Colors.black,size: 20),
          items: const [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.solidUser),label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.format_align_center),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded),label: 'Friends'),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.solidComment),label: 'Chat'),
      ]),
    );
  }
}
