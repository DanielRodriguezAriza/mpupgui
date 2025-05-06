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

// Struct to hold the data of the colors for different data types
class AppThemeDataColorsDataTypes {
  final Color string;
  final Color int;
  final Color float;

  const AppThemeDataColorsDataTypes({
    this.string = const Color.fromARGB(255, 190, 5, 10), // originally it was 189, 6, 11, but these are the slightly "refined" values
    this.int = const Color.fromARGB(255, 15, 173, 196),
    this.float = const Color.fromARGB(255, 86, 179, 30),
  });
}

// Struct to hold the data of the colors for image and text fields.
class AppThemeDataColorsData {
  final List<Color> image;
  final List<Color> text;
  final AppThemeDataColorsDataTypes type;

  const AppThemeDataColorsData({
    required this.image,
    required this.text,
    this.type = const AppThemeDataColorsDataTypes(),
  });
}

// Struct to hold the data of the different types of border radii that can be
// found throughout the app.
class AppThemeDataPaddingData {
  final double inner;
  final double outer;

  const AppThemeDataPaddingData({
    required this.inner,
    required this.outer,
  });
}

// Simple struct to contain the data for a specific theme.
// This is done like this so that users can define custom themes in the future.
class AppThemeData {

  final double borderRadius;
  final AppThemeDataColorsData colors;
  final AppThemeDataPaddingData padding;
  final int darkening;

  const AppThemeData({
    required this.colors,
    required this.padding,
    required this.borderRadius,
    required this.darkening,
  });
}

class ThemeManager {

  // Variables
  static AppTheme currentTheme = AppTheme.dark;
  static const Map<AppTheme, AppThemeData> colorsApp = {
    AppTheme.dark: AppThemeData(
      colors: AppThemeDataColorsData(
        image: [
          Color.fromARGB(255, 23, 23, 23),
          Color.fromARGB(255, 43, 43, 43),
          Color.fromARGB(255, 54, 54, 54),
          Color.fromARGB(255, 128, 128, 128),
        ],
        text: [
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
      padding: AppThemeDataPaddingData(
        inner: 5.0,
        outer: 5.0,
      ),
      borderRadius: 5,
      darkening: 30,
    ),
    AppTheme.mid: AppThemeData(
      colors: AppThemeDataColorsData(
        image: [
          Color.fromARGB(255, 53, 53, 53),
          Color.fromARGB(255, 73, 73, 73),
          Color.fromARGB(255, 120, 120, 120),
          Color.fromARGB(255, 160, 160, 160),
        ],
        text: [
          Color.fromARGB(255, 0, 0, 0),
        ],
      ),
      padding: AppThemeDataPaddingData(
        inner: 5.0,
        outer: 5.0,
      ),
      borderRadius: 5,
      darkening: 5,
    ),
    AppTheme.light: AppThemeData(
      colors: AppThemeDataColorsData(
        image: [
          Color.fromARGB(255, 100, 100, 100),
          Color.fromARGB(255, 145, 145, 145),
          Color.fromARGB(255, 195, 195, 195),
          Color.fromARGB(255, 200, 200, 200),
        ],
        text: [
          Color.fromARGB(255, 0, 0, 0),
        ]
      ),
      padding: AppThemeDataPaddingData(
        inner: 5.0,
        outer: 5.0
      ),
      borderRadius: 5,
      darkening: 5,
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

    // Get the list of colors based on the type of color we are checking for
    List<Color> arr;
    switch(themeType) {
      case AppThemeType.image: arr = colorsApp[appTheme]!.colors.image;
      case AppThemeType.text: arr = colorsApp[appTheme]!.colors.text;
      default: arr = colorsApp[appTheme]!.colors.image;
    }

    // Get the array length and check if it has at least 1 single color element within it
    int length = arr.length;
    if(length <= 0) {
      return false;
    }

    // If the index is not valid, then we return false
    if(idx < 0 || idx >= length) {
      return false;
    }

    // return true in the case that the color index is actually valid
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
  // NOTE : These functions are deprecated and only exist so that we can compile the program, because there's still legacy code
  // that relies on it.
  // Nowadays, what we should do instead is get the theme data and then access the .colors.image or .colors.text properties, etc...
  static Color getColorInternal(AppTheme theme, AppThemeType themeType, int level) {
    if(!isValidColorIndex(theme, themeType, level)) {
      return Colors.black;
    }
    switch(themeType) {
      case AppThemeType.image: return colorsApp[theme]!.colors.image[level];
      case AppThemeType.text: return colorsApp[theme]!.colors.text[level];
    }
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
}