import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/authentication/authentication_bloc.dart';
import 'package:mbunge/models/register_request.dart';
import 'dart:math' as math;

import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/util/routes.dart';
import 'package:mbunge/widgets/restart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ProfilePage> {
  AuthenticationBloc _authenticationBloc;
  final SharePreferenceRepo sharePreferenceRepo = SharePreferenceRepo();
  User user;
  bool isIos = true; //Platform.isIOS;
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
    _authenticationBloc = AuthenticationBloc(sharePreferenceRepo);
    getProfile();
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

  getProfile() async {
    String userString = await sharePreferenceRepo.getUsert();
    if (userString != null || userString.isNotEmpty) {
      try {
        final userMap = jsonDecode(userString);
        user = User.fromJson(userMap);
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _authenticationBloc?.close();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    super.build(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => _authenticationBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              // RestartWidget.restartApp(context);
              print("From profile page loggout");
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/spalsh",
                ModalRoute.withName('/home'),
              );
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // buildBanner(context),
                      SizedBox(
                        height: size.height * 0.35,
                      ),
                      buildAccount(context),
                      // Divider(indent: 55),
                      // buildAppearance(context),
                      Divider(indent: 55),
                      buildAbout(context),
                      Divider(indent: 55),
                      buildAppInfo(),
                    ],
                  ),
                ),
              ),
              buildClipPath(context),
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
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, kToolbarHeight * 1.1, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: themeData.textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontSize: themeData.textTheme.headline6.fontSize * 1.3,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Name:",
                  style: themeData.textTheme.subtitle1.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  user != null
                      ? "${user.firstName} ${user.lastName}"
                      : 'John Doe',
                  // style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Phone:",
                  style: themeData.textTheme.subtitle1.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(width: 13),
                Text(
                  user != null ? "${user.phoneNumber}" : '+254727000000',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Email:",
                  style: themeData.textTheme.subtitle1.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(width: 19),
                Text(
                  user != null ? "${user.emailAddress}" : 'example@gmail.com',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, kToolbarHeight * 1.1, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: theme.textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontSize: theme.textTheme.headline6.fontSize * 1.3,
                ),
              ),
              Spacer(),
              CircleAvatar(
                child: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Name:",
                style: theme.textTheme.subtitle1.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(width: 15),
              Text(
                user != null
                    ? "${user.firstName} ${user.lastName}"
                    : 'John Doe',
                // style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Phone:",
                style: theme.textTheme.subtitle1.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(width: 13),
              Text(
                user != null ? "${user.phoneNumber}" : '+254727000000',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Email:",
                style: theme.textTheme.subtitle1.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(width: 19),
              Text(
                user != null ? "${user.emailAddress}" : 'example@gmail.com',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.editProfileRoute,
                          arguments: user,
                        );
                      },
                    ),
                    ListTile(
                      title: Text("Leave mbunge app"),
                      subtitle: Text(
                        "Permanently delete your account from our system",
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Logout"),
                      subtitle: Text(
                        "Currently signed in as ${user?.emailAddress ?? ""}",
                      ),
                      onTap: () {
                        _authenticationBloc.add(LoggedOut());
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

  // Widget buildAppearance(BuildContext context) {
  //   return Opacity(
  //     opacity: apperanceOpacity.value,
  //     child: Transform.translate(
  //       offset: apperanceOffset.value,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 Icon(
  //                   Icons.style,
  //                   color: Theme.of(context).primaryColor,
  //                   size: 28,
  //                 ),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   "Appearance",
  //                   style: Theme.of(context).textTheme.title,
  //                 )
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 22.0),
  //               child: ListTile(
  //                 title: Text("Theme"),
  //                 subtitle: Text("Dark, light or the system default"),
  //                 trailing: PopupMenuButton<String>(
  //                   onSelected: (value) {
  //                     print(value);
  //                   },
  //                   itemBuilder: (BuildContext context) {
  //                     return <String>['Light', 'Dark', 'System']
  //                         .map((String value) {
  //                       return PopupMenuItem(
  //                         value: value,
  //                         child: new Text(value),
  //                       );
  //                     }).toList();
  //                   },
  //                 ),

  //                 // trailing: IconButton(
  //                 //   icon: Icon(Icons.arrow_drop_down),
  //                 //   onPressed: () {},
  //                 // ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                        String url =
                            "mailto:858wpwaweru@gmail.com?subject=Mbunge%20Feedback";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    ListTile(
                      title: Text("Share this app"),
                      onTap: () {
                        Share.share("https://github.com/Iampato");
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
