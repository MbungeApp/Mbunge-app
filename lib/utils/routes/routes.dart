import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/pages/_pageindex.dart';
import 'package:mbunge/pages/home.dart';

class AppRouter {
  static const String decideRoute = '/';
  static const String splashRoute = '/splash';
  static const String themeRoute = '/theme';
  static const String accountRoute = '/account';
  static const String verifyRoute = '/verify';
  static const String navRoute = '/home';
  static const String particiRoute = '/parti_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case decideRoute:
        return _route(Decide());
        break;
      case splashRoute:
        return _route(SplashScreen());
        break;
      case themeRoute:
        return _route(ThemeChoose());
        break;
      case accountRoute:
        return _route(AccountPage());
        break;
      case verifyRoute:
        return _route(ConfirmCode());
        break;
      case navRoute:
        return _route(MainScreen());
        break;
      case particiRoute:
        Participation participation = args;
        return _route(ParticipationDetail(
          participation: participation,
        ));
        break;
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: Text('mbunge'),
            ),
            body: Center(
              child: Text('Unknown page'),
            ),
          ),
        );
    }
  }

  static _route(Widget page) {
    return CupertinoPageRoute(builder: (context) {
      return page;
    });
  }
}
