import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbunge/utils/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io' show Platform;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool isIos = Platform.isIOS;
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoApp(
            title: 'Mbunge App',
            theme: CupertinoThemeData(
              // brightness: Brightness.dark,
              primaryColor: CupertinoColors.activeOrange,
            ),
            onGenerateRoute: Router.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'), // English
              const Locale('sw'), // Kiswahili
            ],
          )
        : MaterialApp(
            title: 'Mbunge App',
            theme: ThemeData(
              // brightness: Brightness.dark,
              primarySwatch: Colors.deepOrange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: Router.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'), // English
              const Locale('sw'), // Kiswahili
            ],
          );
  }
}
