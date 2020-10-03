import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'event_item.dart';
import 'dart:io' show Platform;

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isIos= true;//Platform.isIOS;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              heroTag: "events-tag",
              transitionBetweenRoutes: false,
              middle: Text("Events & News"),
            ),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) {
                return EventItem();
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Events & News"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) {
                return EventItem();
              },
            ),
          );
  }
}
