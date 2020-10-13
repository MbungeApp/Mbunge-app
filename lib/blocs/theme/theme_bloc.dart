import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_themes.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.Green]));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeDecide) {
      int current = await getOption();
      if (current == 0) {
        print("empty");
        yield ThemeState(themeData: appThemeData[AppTheme.Green]);
      } else {
        print("Theme not empty $current");
        yield ThemeState(themeData: appThemeData[getDecide(current)]);
      }
    }
    if (event is ThemeChanged) {
      try {
        saveOptionValue(event.theme);
      } catch (_) {
        throw Exception("Could not persist change");
      }
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }

  Future<void> saveOptionValue(AppTheme optionValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('apptheme', setDecide(optionValue));
  }

  Future<int> getOption() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int option = preferences.getInt('apptheme') ?? 0;
    return option;
  }

  setDecide(AppTheme x) {
    int i;
    switch (x) {
      case AppTheme.Green:
        i = 0;
        break;
      case AppTheme.Blue:
        i = 1;
        break;
      case AppTheme.Red:
        i = 2;
        break;
      case AppTheme.Pink:
        i = 3;
        break;
      case AppTheme.Purple:
        i = 4;
        break;
      case AppTheme.Orange:
        i = 5;
        break;
      case AppTheme.DarkTheme:
        i = 6;
        break;
    }
    return i;
  }

  getDecide(int i) {
    AppTheme x;
    switch (i) {
      case 0:
        x = AppTheme.Green;
        break;
      case 1:
        x = AppTheme.Blue;
        break;
      case 2:
        x = AppTheme.Red;
        break;
      case 3:
        x = AppTheme.Pink;
        break;
      case 4:
        x = AppTheme.Purple;
        break;
      case 5:
        x = AppTheme.Orange;
        break;
      case 6:
        x = AppTheme.DarkTheme;
        break;
    }
    return x;
  }
}
