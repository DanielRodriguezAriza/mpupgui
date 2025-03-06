import 'package:flutter/material.dart';

enum Theme {
  dark,
  light
}

enum ThemeType {
  image,
  text
}

class ThemeManager {

  static Theme currentTheme = Theme.dark;

  static const Map<ThemeType, Map<Theme, List<Color>>> colorsApp = {
    ThemeType.image : {
      Theme.dark: [
        Color.fromARGB(255, 23, 23, 23),
        Color.fromARGB(255, 43, 43, 43),
        Color.fromARGB(255, 54, 54, 54),
        Color.fromARGB(255, 128, 128, 128),
      ],
      Theme.light: [
        Color.fromARGB(255, 53, 53, 53),
        Color.fromARGB(255, 73, 73, 73),
        Color.fromARGB(255, 120, 120, 120),
        Color.fromARGB(255, 160, 160, 160),
      ]
    },
    ThemeType.text : {
      Theme.dark: [
        Color.fromARGB(255, 255, 255, 255),
      ],
      Theme.light: [
        Color.fromARGB(255, 0, 0, 0),
      ]
    }
  };

  static void setTheme(Theme theme) {
    currentTheme = theme;
  }

  static bool isValidColorIndex(ThemeType themeType, Theme theme, int idx) {
    
    if(!colorsApp.containsKey(themeType)) {
      return false;
    }

    if(!colorsApp[themeType]!.containsKey(theme)) {
      return false;
    }
    
    int length = colorsApp[themeType]![theme]!.length;
    if(length <= 0) {
      return false;
    }
    if(idx < 0 || idx >= length) {
      return false;
    }

    return true;
  }

  static Color getColorInternal(ThemeType themeType, Theme theme, int level) {
    if(!isValidColorIndex(themeType, theme, level)) {
      return Colors.black;
    }
    return colorsApp[themeType]![theme]![level];
  }

  static Color getColor(ThemeType themeType, int level) {
    return getColorInternal(themeType, currentTheme, level);
  }

  static Color getColorImage(int level) {
    return getColor(ThemeType.image, level);
  }

  static Color getColorText(int level) {
    return getColor(ThemeType.text, level);
  }

}