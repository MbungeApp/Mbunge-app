import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'app_themes.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class ThemeDecide extends ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({@required this.theme});
  @override
  List<Object> get props => [theme];
}
