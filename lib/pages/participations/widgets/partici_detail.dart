import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mbunge/cubit/responses/getresponses_bloc.dart';
import 'package:mbunge/models/reponses.dart';
import 'package:mbunge/models/webinar_model.dart';
import 'package:mbunge/pages/participations/widgets/add_reponse.dart';
import 'package:mbunge/pages/participations/widgets/live_stream.dart';
import 'package:mbunge/repository/webinar_repository.dart';
import 'package:mbunge/widgets/readmore.dart';

const double _fabDimension = 56.0;

class ParticipationDetail extends StatefulWidget {
  final WebinarModel webinarModel;
  const ParticipationDetail({Key key, @required this.webinarModel})
      : super(key: key);
  @override
  _ParticipationDetailState createState() => _ParticipationDetailState();
}

class _ParticipationDetailState extends State<ParticipationDetail> {
  WebinarModel get webinarModel => widget.webinarModel;
  List<Responses> responses;
  final _listKey = GlobalKey<AnimatedListState>();
  DateTime current = DateTime.now().toUtc();
  Stream timer;

  @override
  void initState() {
    timer = Stream.periodic(Duration(seconds: 1), (i) {
      current = current.add(Duration(seconds: 1));
      return current;
    }).asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight / 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${webinarModel.agenda}",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    webinarModel.postponed
                        ? Text(
                            "postponed",
                            style: TextStyle(color: Colors.red),
                          )
                        : MyBlinking(
                            child: StreamBuilder<DateTime>(
                              stream: timer,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (webinarModel.scheduleAt
                                          .compareTo(snapshot.data) >
                                      0) {
                                    Duration duration = webinarModel.scheduleAt
                                        .difference(snapshot.data);
                                    return Text(
                                      // "Stream has not yet started",
                                      "${duration.inHours} hrs to go",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  } else {
                                    return Text(
                                      "Live stream ended",
                                    );
                                  }
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Duration: ${webinarModel.duration} hrs",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Text(
                      //yMMMMEEEEd
                      DateFormat.yMEd().add_jms().format(
                            webinarModel.scheduleAt,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Image.asset(
                      "assets/images/bg.png",
                      height: MediaQuery.of(context).size.height / 3,
                      cacheHeight: (MediaQuery.of(context).size.height ~/ 3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Guest speaker: ",
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      webinarModel.hostedBy,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                child: ReadMoreText(
                  "${webinarModel.description}",
                  style: TextStyle(fontSize: 16),
                  trimLines: 8,
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Questions:",
                ),
              ),
              BlocProvider(
                create: (context) => GetresponsesBloc(WebinarRepository())
                  ..add(
                    FetchResponses(webinarModel.id),
                  ),
                child: BlocBuilder<GetresponsesBloc, GetresponsesState>(
                  builder: (context, state) {
                    if (state is GetresponsesInitial) {
                      return Center(child: CupertinoActivityIndicator());
                    }
                    if (state is GetresponsesError) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No Responses",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }
                    if (state is GetresponsesLoaded) {
                      responses = state.responses;
                      if (responses.isEmpty) {
                        return Center(child: Text("No Responses"));
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: AnimatedList(
                          initialItemCount: responses.length,
                          shrinkWrap: true,
                          key: _listKey,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-1, 0),
                                end: Offset(0, 0),
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.decelerate,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white60,
                                  ),
                                ),
                                isThreeLine: true,
                                title: Text(
                                    "@${responses[index].user.firstName}"
                                        .toLowerCase()),
                                subtitle: Text("${responses[index].body}"),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) {
                  return LiveStreamPage(
                    id: webinarModel.id,
                  );
                }),
              );
            },
            child: Icon(Icons.live_tv),
          ),
          SizedBox(height: 10),
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            openBuilder: (BuildContext context, VoidCallback results) {
              return AddReponse(
                particiId: webinarModel.id,
              );
            },
            onClosed: (results) {
              if (results != null) {
                print("Length before: ${responses?.length ?? 0}");
                print("$results");
                if (responses == null) {
                  responses = List();
                  responses.add(results);
                } else {
                  responses.add(results);
                }
                _listKey.currentState.insertItem(
                  0,
                  duration: const Duration(milliseconds: 500),
                );
                print("Length after: ${responses?.length ?? 0}");
              }
            },
            closedElevation: 6.0,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_fabDimension / 2),
              ),
            ),
            closedColor: Theme.of(context).primaryColor,
            transitionDuration: Duration(milliseconds: 800),
            closedBuilder: (BuildContext context, VoidCallback openContainer) {
              return SizedBox(
                height: _fabDimension,
                width: _fabDimension,
                child: Center(
                  child: Icon(Icons.add),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyBlinking extends StatefulWidget {
  final Widget child;

  const MyBlinking({Key key, this.child}) : super(key: key);
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinking>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
