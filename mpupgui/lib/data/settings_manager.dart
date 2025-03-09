import 'dart:convert';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

class SettingsManager {

  static const String settingsFile = "./mpupgui_settings.json";

  static void loadSettings() {
    try {
      var str = readStringFromFile(settingsFile);
      var data = jsonDecode(str);

      Language language = Language.values.byName(data["Language"]);
      AppTheme theme = AppTheme.values.byName(data["Theme"]);
      String mpupPath = data["MagickaPupPath"];

      LanguageManager.setLanguage(language);
      ThemeManager.setTheme(theme);
      MagickaPupManager.setMagickaPupPath(mpupPath);

    } catch(e) {
      print("SettingsManager.loadSettings() has failed : $e");
    }
  }

  static void saveSettings() {
    try {
      Map<String, dynamic> data = {
        "Language" : LanguageManager.currentLanguage.name,
        "Theme" : ThemeManager.currentTheme.name,
        "MagickaPupPath" : MagickaPupManager.currentMagickaPupPath,
      };
      var str = jsonEncode(data);
      writeStringToFile(settingsFile, str);
    } catch(e) {
      print("SettingsManager.saveSettings() has failed : $e");
    }
  }
}
