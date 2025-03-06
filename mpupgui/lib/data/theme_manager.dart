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

  static void setTheme(Theme theme) {
    currentTheme = theme;
  }

  static int getMinValidColorIndex() {
    return 0;
  }

  static int getMaxValidColorIndex() {
    if(colorsApp.isEmpty) {
      return 0;
    }

    int currentLength = colorsApp.entries.first.value.length;

    for(var map in colorsApp.entries) {
      if(currentLength > map.value.length) {
        currentLength = map.value.length;
      }
    }

    return currentLength - 1;
  }

  static Color getColorByTheme(Theme theme, int level) {
    if(level < 0 || level >= 3) {
      return Colors.black;
    }
    return colorsApp[theme]![level];
  }

  static Color getColor(int level) {
    return getColorByTheme(currentTheme, level);
  }

}