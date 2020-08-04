
import 'package:flutter/material.dart';

enum AppTheme {
  Green,
  Blue,
  Red,
  Pink,
  Purple,
  Orange,
  DarkTheme,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.Green: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
  ),
  AppTheme.Blue: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  ),
  AppTheme.Red: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
  ),
  AppTheme.Pink: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pink,
  ),
  AppTheme.Purple: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple,
  ),
  AppTheme.Orange: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
  ),
  AppTheme.DarkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange[700],
  ),
};
