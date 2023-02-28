import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getmarried/presentation/screens/home/chat/chat_tab.dart';
import 'package:getmarried/presentation/screens/home/home_tab/home_tab.dart';
import 'package:getmarried/presentation/screens/home/likes_tab/like_refractor.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/profile_tab.dart';
import 'package:getmarried/widgets/home/connection_menu_item.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); //

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
      key: scaffoldKey,
      drawer: const _HomeDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ProfileTab(),
          HomeTab(),
          LikeRefractor(),
          ChatTab(),
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

class _HomeDrawer extends StatefulWidget {
  const _HomeDrawer({Key? key}) : super(key: key);

  @override
  State<_HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<_HomeDrawer> {
  String connection = 'date';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(10),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          const Text('Choose a connection',style: TextStyle(color: Colors.grey),),
          ConnectionMenuItem(
            isSelected: connection == 'date',
            subtittle: 'Make moves to find that spark',
            tittle: 'Date', onTap: () {
              setState(() {
                connection = 'date';
              });
          },
          ),
          ConnectionMenuItem(
            isSelected: connection == 'bff',
            subtittle: 'Make friends and find community',
            tittle: 'bff', onTap: () {
            setState(() {
              connection = 'bff';
            });
          },
          )
        ],
      ),
    );
  }
}
