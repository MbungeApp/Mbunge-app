import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// abstract class ThemeState extends Equatable {
//   const ThemeState();
//   List<Object> get props => [];
// }

class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState({@required this.themeData});

  @override
  List<Object> get props => [themeData];
}
