import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getmarried/presentation/screens/home/home_tab/home_tab.dart';
import 'package:getmarried/presentation/screens/home/likes_tab/like_refractor.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,

        children: [
          const ProfileTab(),
          const HomeTab(),
          const LikeRefractor(),

          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _currentIndex,

          unselectedIconTheme:
              const IconThemeData(color: Colors.grey, size: 25),
          onTap: (index) {

            setState(() {
              _currentIndex = index;
            });

          },
          selectedIconTheme: const IconThemeData(color: Colors.black, size: 25),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidUser), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: 'Friends'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidComment), label: 'Chat'),
          ]),
    );
  }
}
