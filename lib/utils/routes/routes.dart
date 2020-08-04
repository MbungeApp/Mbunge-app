import 'package:flutter/material.dart';
import 'package:mbunge/pages/_pageindex.dart';

class Router {
  static const String splashRoute = '/';
  static const String themeRoute = '/theme';
  static const String accountRoute = '/account';
  static const String verifyRoute = '/verify';
  static const String navRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
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
    return MaterialPageRoute(builder: (context) {
      return page;
    });
  }
}
