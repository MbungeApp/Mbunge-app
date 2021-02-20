import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:mbunge/pages/events/event_page.dart';
import 'package:mbunge/pages/mp/mp_page.dart';
import 'package:mbunge/pages/participations/participation_page.dart';
import 'package:mbunge/pages/profile/profile.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Widget> pageList = <Widget>[
    ParticipationPage(),
    EventPage(),
    MPPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pageList,
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeShape: SnakeShape.indicator,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: changePage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'weekly mp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          )
        ],
      ),
    );
  }
}
