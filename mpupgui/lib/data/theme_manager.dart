import 'package:flutter/material.dart';

enum AppTheme {
  dark,
  mid,
  light
}

enum AppThemeType {
  image,
  text
}

class ThemeManager {

  static AppTheme currentTheme = AppTheme.dark;

  static const Map<AppThemeType, Map<AppTheme, List<Color>>> colorsApp = {
    AppThemeType.image : {
      AppTheme.dark: [
        Color.fromARGB(255, 23, 23, 23),
        Color.fromARGB(255, 43, 43, 43),
        Color.fromARGB(255, 54, 54, 54),
        Color.fromARGB(255, 128, 128, 128),
      ],
      AppTheme.mid: [
        Color.fromARGB(255, 53, 53, 53),
        Color.fromARGB(255, 73, 73, 73),
        Color.fromARGB(255, 120, 120, 120),
        Color.fromARGB(255, 160, 160, 160),
      ],
      AppTheme.light: [
        Color.fromARGB(255, 100, 100, 100),
        Color.fromARGB(255, 145, 145, 145),
        Color.fromARGB(255, 195, 195, 195),
        Color.fromARGB(255, 200, 200, 200),
      ]
    },
    AppThemeType.text : {
      AppTheme.dark: [
        Color.fromARGB(255, 255, 255, 255),
      ],
      AppTheme.mid: [
        Color.fromARGB(255, 0, 0, 0),
      ],
      AppTheme.light: [
        Color.fromARGB(255, 0, 0, 0),
      ]
    }
  };

  static void setTheme(AppTheme theme) {
    currentTheme = theme;
  }

  static bool isValidColorIndex(AppThemeType themeType, AppTheme theme, int idx) {
    
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

  static Color getColorInternal(AppThemeType themeType, AppTheme theme, int level) {
    if(!isValidColorIndex(themeType, theme, level)) {
      return Colors.black;
    }
    return colorsApp[themeType]![theme]![level];
  }

  static Color getColor(AppThemeType themeType, int level) {
    return getColorInternal(themeType, currentTheme, level);
  }

  static Color getColorImage(int level) {
    return getColor(AppThemeType.image, level);
  }

  static Color getColorText(int level) {
    return getColor(AppThemeType.text, level);
  }

}