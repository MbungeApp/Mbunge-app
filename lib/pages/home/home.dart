import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbunge/pages/pariticipate/participate.dart';
import 'package:mbunge/pages/trending/trending.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 0;
  bool isIos = true; //Platform.isIOS;

  final Map<int, Widget> pages = const <int, Widget>{
    0: Text(
      "Participation",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
    1: Text(
      "Trending",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  };

  @override
  void initState() {
    _tabController = TabController(length: pages.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              automaticallyImplyLeading: false,
              middle: CupertinoSlidingSegmentedControl(
                groupValue: currentIndex,
                children: pages,
                onValueChanged: (i) {
                  setState(() {
                    _tabController.index = i;
                  });
                },
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ParticipatePage(),
                TrendingPage(),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Public Participation"),
              centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.amber,
                tabs: [
                  Tab(
                    icon: Icon(Icons.people),
                  ),
                  Tab(
                    icon: Icon(Icons.trending_up),
                  )
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ParticipatePage(),
                TrendingPage(),
              ],
            ),
          );
  }
}
