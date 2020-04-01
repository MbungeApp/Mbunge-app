import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/blocs/event/event_bloc.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/event_repository.dart';
import 'package:mbunge/widgets/shimmer.dart';
import 'event_detail.dart';
import 'event_item.dart';
import 'dart:io' show Platform;

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isIos = true; //Platform.isIOS;

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
            child: BlocProvider(
              create: (context) => EventBloc(EventRepository())
                ..add(
                  LoadingEvents(),
                ),
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventInitial) {
                    return Center(
                      child: Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.white],
                        ),
                        child: Text(
                          "Mbunge",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  }
                  if (state is EventsError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is EventsLoaded) {
                    List<Event> events = state.events;
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, i) {
                        return EventItem(
                          name: events[i].name,
                          body: events[i].body,
                          created: events[i].createdAt,
                          image: events[i].picture,
                          ontap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return EventDetail(event:events[i]);
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
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
