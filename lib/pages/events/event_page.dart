import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/event/event_cubit.dart';
import 'package:mbunge/models/event.dart';
import 'package:mbunge/repository/event_repository.dart';
import 'package:mbunge/util/routes.dart';
import 'package:mbunge/widgets/error_wdget.dart';
import 'package:shimmer/shimmer.dart';
import 'widgets/event_item.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Completer<void> _refreshCompleter;
  EventCubit eventCubit;

  @override
  void initState() {
    eventCubit = EventCubit(EventRepository())..getEvents();
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildClipPath(context),
          BlocProvider(
            create: (context) => eventCubit,
            child: RefreshIndicator(
              onRefresh: () async {
                await eventCubit.getEvents();
                return _refreshCompleter.future;
              },
              child: BlocListener<EventCubit, EventState>(
                listener: (context, state) {
                  if (state is EventsLoaded) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                  }
                },
                child: BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventInitial) {
                      return Center(
                        child: Image.asset("assets/images/loading.gif"),
                      );
                    }
                    if (state is EventsError) {
                      return ErrorAppWidget(
                        message: "An error occured",
                      );
                    }
                    if (state is EventsLoaded) {
                      List<Event> events = state.events;
                      // _events.insert(0, null);
                      // List<Event> events = _events;
                      return Padding(
                        padding:
                            EdgeInsets.fromLTRB(5, kToolbarHeight / 1.5, 5, 0),
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, i) {
                            if (i == 0) {
                              return buildBanner(context);
                            } else {
                              return EventItem(
                                name: events[i].name,
                                body: events[i].body,
                                created: events[i].createdAt,
                                image: events[i].picture,
                                ontap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.eventDetailRoute,
                                    arguments: events[i],
                                  );
                                },
                              );
                            }
                          },
                          // separatorBuilder: (BuildContext context, int index) {
                          //   return Divider();
                          // },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClipPath(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            themeData.primaryColor,
            themeData.primaryColor,
            Colors.blue,
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Events & News",
            style: theme.textTheme.headline6.copyWith(
              color: Colors.white,
              fontSize: theme.textTheme.headline6.fontSize * 1.3,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "The following are available parliament events and news",
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
