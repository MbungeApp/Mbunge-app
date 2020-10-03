import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io' show Platform;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ProfilePage> {
  bool isIos = true;//Platform.isIOS;
  AnimationController _controller;

  Animation<Offset> profileOffset;
  Animation<Offset> nameOffset;
  Animation<Offset> infoOffset;
  Animation<Offset> accountOffset;
  Animation<Offset> apperanceOffset;
  Animation<Offset> aboutOffset;

  Animation<double> profileRotate;

  Animation<double> profileOpacity;
  Animation<double> nameOpacity;
  Animation<double> infoOpacity;
  Animation<double> accountOpacity;
  Animation<double> apperanceOpacity;
  Animation<double> aboutOpacity;

  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1800))
          ..addListener(() {
            setState(() {});
          })
          ..forward();
    profileOffset = Tween<Offset>(begin: Offset(100, 0), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.2, 0.5, curve: Curves.decelerate)))
        .animate(_controller);
    profileRotate = Tween<double>(begin: math.pi * 3, end: 0)
        .chain(CurveTween(curve: Interval(0.1, 0.5, curve: Curves.decelerate)))
        .animate(_controller);
    nameOffset = Tween<Offset>(begin: Offset(100, 0), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.3, 0.6, curve: Curves.decelerate)))
        .animate(_controller);
    infoOffset = Tween<Offset>(begin: Offset(100, 0), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.4, 0.7, curve: Curves.decelerate)))
        .animate(_controller);
    accountOffset = Tween<Offset>(begin: Offset(0, 100), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.5, 0.8, curve: Curves.decelerate)))
        .animate(_controller);
    apperanceOffset = Tween<Offset>(begin: Offset(0, 100), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.6, 0.9, curve: Curves.decelerate)))
        .animate(_controller);
    aboutOffset = Tween<Offset>(begin: Offset(0, 100), end: Offset.zero)
        .chain(CurveTween(curve: Interval(0.7, 1.0, curve: Curves.decelerate)))
        .animate(_controller);

    profileOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1, 0.5),
    );
    nameOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.6),
    );
    infoOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.4, 0.7),
    );
    accountOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.6, 0.8),
    );
    apperanceOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.7, 0.9),
    );
    aboutOpacity = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.8, 1.0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isIos
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Profile"),
            ),
            child: Material(
              child: ListView(
                children: <Widget>[
                  buildSummary(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                  ),
                  buildAccount(context),
                  Divider(indent: 55),
                  buildAppearance(context),
                  Divider(indent: 55),
                  buildAbout(context),
                  Divider(indent: 55),
                  buildAppInfo(),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              centerTitle: true,
            ),
            body: ListView(
              children: <Widget>[
                buildSummary(context),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                ),
                buildAccount(context),
                Divider(indent: 55),
                buildAppearance(context),
                Divider(indent: 55),
                buildAbout(context),
                Divider(indent: 55),
                buildAppInfo(),
              ],
            ),
          );
  }

  Widget buildSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: profileOpacity.value,
            child: Transform.translate(
              offset: profileOffset.value,
              child: Transform.rotate(
                angle: profileRotate.value,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/no-pic.png",
                    ),
                    radius: 70,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: nameOpacity.value,
            child: Transform.translate(
              offset: nameOffset.value,
              child: Text(
                'John Doe',
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          SizedBox(height: 10),
          Opacity(
            opacity: infoOpacity.value,
            child: Transform.translate(
              offset: infoOffset.value,
              child: buildSummaryBody(context),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSummaryBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.7,
          child: Text(
            '+254727000000',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        VerticalDivider(),
        Opacity(
          opacity: 0.7,
          child: Text(
            'example@gmail.com',
            style: Theme.of(context).textTheme.subhead,
          ),
        )
      ],
    );
  }

  Widget buildAccount(BuildContext context) {
    return Opacity(
      opacity: accountOpacity.value,
      child: Transform.translate(
        offset: accountOffset.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.people,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Account",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Personal"),
                      subtitle: Text("Edit my account details"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Favourite"),
                      subtitle: Text(
                        "Checkout your favourite public participations",
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text("Logout"),
                      subtitle: Text(
                        "Currently signed in as example@gmail.com",
                      ),
                      onTap: () {
                        // widget.authBloc.add(LoggedOut());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppearance(BuildContext context) {
    return Opacity(
      opacity: apperanceOpacity.value,
      child: Transform.translate(
        offset: apperanceOffset.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.style,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Appearance",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ListTile(
                  title: Text("Theme"),
                  subtitle: Text("Dark, light or the system default"),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext context) {
                      return <String>['Light', 'Dark', 'System']
                          .map((String value) {
                        return PopupMenuItem(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList();
                    },
                  ),

                  // trailing: IconButton(
                  //   icon: Icon(Icons.arrow_drop_down),
                  //   onPressed: () {},
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAbout(BuildContext context) {
    return Opacity(
      opacity: aboutOpacity.value,
      child: Transform.translate(
        offset: aboutOffset.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "About",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Give feedback"),
                      onTap: () async {
                        // String url =
                        //     "mailto:858wpwaweru@gmail.com?subject=Mbunge%20Feedback";
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
                      },
                    ),
                    ListTile(
                      title: Text("Share this app"),
                      onTap: () {
                        // Share.share("https://github.com/Iampato");
                      },
                    ),
                    ListTile(
                      title: Text("Privacy and Security Policy"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            height: 90,
          ),
          Text("MbungeApp"),
          Text("Version 2.0.0"),
          Text("Build 4"),
          Text("Copyright \u00a9 2020 - " + DateTime.now().year.toString())
        ],
      ),
    );
  }
}
