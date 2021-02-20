import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/webinar/webinar_cubit.dart';
import 'package:mbunge/pages/participations/widgets/partici_detail.dart';
import 'package:mbunge/pages/participations/widgets/partici_item.dart';
import 'package:mbunge/repository/webinar_repository.dart';
import 'package:mbunge/widgets/shimmer.dart';

class ParticipationPage extends StatefulWidget {
  @override
  _ParticipationPageState createState() => _ParticipationPageState();
}

class _ParticipationPageState extends State<ParticipationPage> {
  WebinarCubit webinarCubit;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    webinarCubit = WebinarCubit(WebinarRepository());
    webinarCubit.fetchWebinars();
    super.initState();
  }

  @override
  void dispose() {
    webinarCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => webinarCubit,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await webinarCubit.fetchWebinars();
            return _refreshCompleter.future;
          },
          child: Stack(
            children: <Widget>[
              buildClipPath(context),
              BlocBuilder(
                cubit: webinarCubit,
                builder: (context, state) {
                  if (state is WebinarInitial) {
                    return WebinarLoader(size: size);
                  }
                  if (state is WebinarError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is WebinarSuccess) {
                    final webinars = state.webinars;
                    return Padding(
                      padding:
                          EdgeInsets.fromLTRB(5, kToolbarHeight / 1.5, 5, 0),
                      child: CupertinoScrollbar(
                        child: ListView.separated(
                          itemCount: webinars.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return buildBanner(context);
                            } else {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) {
                                      return ParticipationDetail(
                                        webinarModel: webinars[index],
                                      );
                                    }),
                                  );
                                },
                                child: ParticipationItem(
                                  webinarModel: webinars[index],
                                ),
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
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
            "Public Particiations",
            style: theme.textTheme.headline6.copyWith(
              color: Colors.white,
              fontSize: theme.textTheme.headline6.fontSize * 1.3,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "The following are available webinars both ongoing and scheduled",
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

class WebinarLoader extends StatelessWidget {
  const WebinarLoader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, kToolbarHeight / 1.5, 5, 0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                  child: Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 5),
                Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                  child: Container(
                    height: 12,
                    width: size.width,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 2),
                Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                  child: Container(
                    height: 12,
                    width: size.width / 3,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.white],
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 2,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          child: AnimatedOpacity(
                            opacity: 0.7,
                            duration: Duration(milliseconds: 400),
                            child: Shimmer(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.white],
                              ),
                              child: Container(
                                height: 35,
                                width: size.width,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 3,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.white],
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 2,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          child: AnimatedOpacity(
                            opacity: 0.7,
                            duration: Duration(milliseconds: 400),
                            child: Shimmer(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.white],
                              ),
                              child: Container(
                                height: 35,
                                width: size.width,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 3,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.white],
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 2,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          child: AnimatedOpacity(
                            opacity: 0.7,
                            duration: Duration(milliseconds: 400),
                            child: Shimmer(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.white],
                              ),
                              child: Container(
                                height: 35,
                                width: size.width,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                        Shimmer(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ),
                          child: Container(
                            height: 10,
                            width: size.width / 3,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        // child: Shimmer(
        //   gradient: LinearGradient(
        //     colors: [Colors.grey, Colors.white],
        //   ),
        //   child: Text(
        //     "Mbunge App",
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        // ),
      ),
    );
  }
}
