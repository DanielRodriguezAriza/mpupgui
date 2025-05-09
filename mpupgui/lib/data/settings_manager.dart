import 'dart:convert';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

class SettingsManager {

  static const String settingsFile = "./mpupgui_settings.json";

  static T? loadValue<T>(var dict, String path) {
    try {
      T ans = dict[path];
      return ans;
    } catch(e) {
      print("SettingsManager.loadValue() has failed : $e");
      return null;
    }
  }

  static void loadSettings() {
    try {
      var str = readStringFromFile(settingsFile);
      var data = jsonDecode(str);

      // Load Language
      String languageStr = loadValue(data, "Language") ?? "english";
      Language language = Language.values.byName(languageStr);
      LanguageManager.setLanguage(language);

      // Load App Theme
      String themeStr = loadValue(data, "Theme") ?? "dark";
      AppTheme theme = AppTheme.values.byName(themeStr);
      ThemeManager.setTheme(theme);

      // Load MagickaPup Path
      String mpupPath = loadValue(data, "MagickaPupPath") ?? "./MagickaPUP.exe";
      MagickaPupManager.setMagickaPupPath(mpupPath);

      // Load path to installs
      String pathToInstalls = loadValue(data, "pathToInstalls") ?? "./installs";
      ModManager.setPathToInstalls(pathToInstalls);

      // Load path to mods
      String pathToMods = loadValue(data, "pathToMods") ?? "./mods";
      ModManager.setPathToMods(pathToMods);

      // Load path to profiles
      String pathToProfiles = loadValue(data, "pathToProfiles") ?? "./profiles";
      ModManager.setPathToProfiles(pathToProfiles);

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
        "pathToInstalls" : ModManager.getPathToInstalls(),
        "pathToMods" : ModManager.getPathToMods(),
        "pathToProfiles" : ModManager.getPathToProfiles()
      };
      var str = jsonEncode(data);
      writeStringToFile(settingsFile, str);
    } catch(e) {
      print("SettingsManager.saveSettings() has failed : $e");
    }
  }
}
