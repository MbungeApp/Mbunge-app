import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mbunge/models/http/_http.dart';

const double _fabDimension = 56.0;

class ParticipationDetail extends StatefulWidget {
  final Participation participation;

  const ParticipationDetail({Key key, @required this.participation})
      : super(key: key);
  @override
  _ParticipationDetailState createState() => _ParticipationDetailState();
}

class _ParticipationDetailState extends State<ParticipationDetail> {
  Participation get participation => widget.participation;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: "participations",
          middle: Text("${participation.name}"),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight * 1.5),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text("Name: ",
                              style: Theme.of(context).textTheme.headline6),
                          Text("${participation.name}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "Posted by: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd()
                                .format(participation.createdAt),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "${participation.body}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Responses:",
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: OpenContainer(
                transitionType: ContainerTransitionType.fade,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return CommentsPage();
                },
                closedElevation: 6.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(_fabDimension / 2),
                  ),
                ),
                closedColor: Theme.of(context).primaryColor,
                transitionDuration: Duration(milliseconds: 800),
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
                  return SizedBox(
                    height: _fabDimension,
                    width: _fabDimension,
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          TextFormField(),
        ],
      ),
    );
  }
}
