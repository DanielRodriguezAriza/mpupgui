import 'package:flutter/material.dart';

enum Theme {
  dark,
  light
}

class ThemeManager {

  static Theme currentTheme = Theme.dark;

  // App colors
  static const Map<Theme, List<Color>> colorsApp = {
    Theme.dark : [
      Color.fromARGB(255, 23, 23, 23),
      Color.fromARGB(255, 43, 43, 43),
      Color.fromARGB(255, 54, 54, 54),
      Color.fromARGB(255, 128, 128, 128),
    ],
    Theme.light : [
      Color.fromARGB(255, 53, 53, 53),
      Color.fromARGB(255, 73, 73, 73),
      Color.fromARGB(255, 120, 120, 120),
      Color.fromARGB(255, 160, 160, 160),
    ]
  };


  // TODO : Implement!
  static Color getColor(int level) {
    return Colors.blue; // For now, always return this color...
  }

}