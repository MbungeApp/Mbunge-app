import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbunge/models/event.dart';
import 'package:mbunge/models/register_request.dart';
import 'package:mbunge/pages/account/account.dart';
import 'package:mbunge/pages/decision.dart';
import 'package:mbunge/pages/events/widgets/event_detail.dart';
import 'package:mbunge/pages/home.dart';
import 'package:mbunge/pages/profile/edit_profile.dart';
import 'package:mbunge/pages/splashscreen/splashscreen.dart';

class AppRouter {
  static const String decisionRoute = '/';
  static const String splashRoute = '/spalsh';
  static const String accountRoute = '/account';
  static const String homeRoute = '/home';
  static const String eventDetailRoute = '/event_detail';
  static const String mpDetailRoute = '/mp_detail';
  static const String editProfileRoute = '/edit_profile';
  static const String participationDetailRoute = '/participation_detail';
  static const String joinStreamRoute = '/join_stream';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case decisionRoute:
        return _route(DecisionPage());
        break;
      case splashRoute:
        return _route(SplashScreenPage());
        break;
      case accountRoute:
        return _route(AccountPage());
        break;
      case homeRoute:
        return _route(MainScreen());
      case editProfileRoute:
        User user = args;
        return _route(EditProfile(
          user: user,
        ));
        break;
      case eventDetailRoute:
        Event event = args;
        return _route(EventDetail(
          event: event,
        ));
        break;
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: Text('Mbunge App'),
            ),
            body: Center(
              child: Text('Unknown page'),
            ),
          ),
        );
        break;
    }
  }

  static _route(Widget page) {
    return CupertinoPageRoute(
      builder: (context) {
        return page;
      },
    );
  }
}
