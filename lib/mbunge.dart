import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mbunge/utils/routes/routes.dart';
import 'dart:io' show Platform;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool isIos = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoApp(
            title: 'Mbunge App',
            theme: CupertinoThemeData(
              // brightness: Brightness.dark,
              primaryColor: Colors.red,
            ),
            onGenerateRoute: AppRouter.generateRoute,
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
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AppRouter.generateRoute,
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
