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

// Simple struct to contain the data for a specific theme.
// This is done like this so that users can define custom themes in the future.
class AppThemeData {

  final Map<AppThemeType, List<Color>> colors;
  final int edgeRoundness;
  final int padding;

  const AppThemeData({
    required this.colors,
    required this.edgeRoundness,
    required this.padding
  });
}

class ThemeManager {

  // Variables
  static AppTheme currentTheme = AppTheme.dark;
  static const Map<AppTheme, AppThemeData> colorsApp = {
    AppTheme.dark: AppThemeData(
      colors: {
        AppThemeType.image: [
          Color.fromARGB(255, 23, 23, 23),
          Color.fromARGB(255, 43, 43, 43),
          Color.fromARGB(255, 54, 54, 54),
          Color.fromARGB(255, 128, 128, 128),
        ],
        AppThemeType.text: [
          Color.fromARGB(255, 255, 255, 255),
        ],
      },
      edgeRoundness: 5,
      padding: 5,
    ),
    AppTheme.mid: AppThemeData(
      colors: {
        AppThemeType.image: [
          Color.fromARGB(255, 53, 53, 53),
          Color.fromARGB(255, 73, 73, 73),
          Color.fromARGB(255, 120, 120, 120),
          Color.fromARGB(255, 160, 160, 160),
        ],
        AppThemeType.text: [
          Color.fromARGB(255, 0, 0, 0),
        ],
      },
      edgeRoundness: 5,
      padding: 5,
    ),
    AppTheme.light: AppThemeData(
      colors: {
        AppThemeType.image: [
          Color.fromARGB(255, 100, 100, 100),
          Color.fromARGB(255, 145, 145, 145),
          Color.fromARGB(255, 195, 195, 195),
          Color.fromARGB(255, 200, 200, 200),
        ],
        AppThemeType.text: [
          Color.fromARGB(255, 0, 0, 0),
        ],
      },
      edgeRoundness: 5,
      padding: 5,
    )
  };

  // Theme Functions
  static void setTheme(AppTheme theme) {
    currentTheme = theme;
  }

  static AppTheme getTheme() {
    return currentTheme;
  }

  // Aux functions
  static bool isValidColorIndex(AppTheme appTheme, AppThemeType themeType, int idx) {

    // If the theme we are searching for does not exist, then we bail out.
    if(!colorsApp.containsKey(appTheme)) {
      return false;
    }

    if(!colorsApp[appTheme]!.colors.containsKey(themeType)) {
      return false;
    }
    
    int length = colorsApp[appTheme]!.colors[themeType]!.length;
    if(length <= 0) {
      return false;
    }
    if(idx < 0 || idx >= length) {
      return false;
    }

    return true;
  }

  // Getter to obtain all of the theme data of an specific theme
  static AppThemeData getThemeData(AppTheme theme) {
    return colorsApp[theme]!;
  }

  // Getter to obtain all of the theme data of the currently enabled theme
  static AppThemeData getCurrentThemeData() {
    return colorsApp[currentTheme]!;
  }

  // Style property getters and setters - Color
  static Color getColorInternal(AppTheme theme, AppThemeType themeType, int level) {
    if(!isValidColorIndex(theme, themeType, level)) {
      return Colors.black;
    }
    return colorsApp[theme]!.colors[themeType]![level];
  }

  static Color getColor(AppThemeType themeType, int level) {
    return getColorInternal(currentTheme, themeType, level);
  }

  static Color getColorImage(int level) {
    return getColor(AppThemeType.image, level);
  }

  static Color getColorText(int level) {
    return getColor(AppThemeType.text, level);
  }

  // Style property getters and setters - Other
  static int getPadding() {
    return colorsApp[currentTheme]!.padding;
  }

}