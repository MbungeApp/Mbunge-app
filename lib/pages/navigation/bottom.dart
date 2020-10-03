import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbunge/pages/events/event.dart';
import 'package:mbunge/pages/home/home.dart';
import 'package:mbunge/pages/mp/mp.dart';
import 'package:mbunge/pages/profile/profile.dart';
import 'package:mbunge/utils/snake/flutter_snake_navigationbar.dart';
import 'dart:io' show Platform;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  bool isIos = true;// Platform.isIOS;

  List<Widget> pageList = <Widget>[
    HomePage(),
    EventPage(),
    MpPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text("home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                title: Text("event"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tag_solid),
                title: Text("weekly mp"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                title: Text("profile"),
              )
            ]),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HomePage();
                  break;
                case 1:
                  return EventPage();
                  break;
                case 2:
                  return MpPage();
                  break;
                case 3:
                  return ProfilePage();
                  break;
                default:
                  return HomePage();
                  break;
              }
            },
          )
        : Scaffold(
            body: PageTransitionSwitcher(
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: pageList[currentIndex],
            ),
            bottomNavigationBar: SnakeNavigationBar(
              snakeShape: SnakeShape.indicator,
              showSelectedLabels: true,
              currentIndex: currentIndex,
              onPositionChanged: changePage,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text('home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  title: Text('event'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  title: Text('weekly mp'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('profile'),
                )
              ],
            ),
          );
  }
}
