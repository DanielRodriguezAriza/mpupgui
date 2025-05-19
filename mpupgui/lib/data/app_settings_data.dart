import 'dart:convert';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

class AppSettingsData {

  late Language language;
  late AppTheme theme;
  late String pathToMagickaPup;
  late String pathToMagickCowModManager;
  late String pathToInstalls;
  late String pathToMods;
  late String pathToProfiles;

  T? _loadValue<T>(var dict, String path) {
    try {
      T ans = dict[path];
      return ans;
    } catch(e) {
      print("AppSettingsData._loadValue() has failed : $e");
      return null;
    }
  }

  void readFromFile(String settingsFile) {
    var str = readStringFromFile(settingsFile);
    var data = jsonDecode(str);

    // Load Language
    String languageStr = _loadValue(data, "Language") ?? "english";
    language = Language.values.byName(languageStr);

    // Load App Theme
    String themeStr = _loadValue(data, "Theme") ?? "dark";
    theme = AppTheme.values.byName(themeStr);

    // Load MagickaPup Path
    pathToMagickaPup = _loadValue(data, "MagickaPupPath") ?? "./MagickaPUP.exe";

    // Load MagickCow mod manager Path
    pathToMagickCowModManager = _loadValue(data, "MagickCowModManagerPath") ?? "./MagickCowModManager.exe";

    // Load path to installs
    pathToInstalls = _loadValue(data, "pathToInstalls") ?? "./installs";

    // Load path to mods
    pathToMods = _loadValue(data, "pathToMods") ?? "./mods";

    // Load path to profiles
    pathToProfiles = _loadValue(data, "pathToProfiles") ?? "./profiles";
  }

  void writeToFile(String settingsFile) {
    Map<String, dynamic> data = {
      "Language" : language.name,
      "Theme" : theme.name,
      "MagickaPupPath" : pathToMagickaPup,
      "MagickCowModManagerPath" : pathToMagickCowModManager,
      "pathToInstalls" : pathToInstalls,
      "pathToMods" : pathToMods,
      "pathToProfiles" : pathToProfiles,
    };
    var str = jsonEncode(data);
    writeStringToFile(settingsFile, str);
  }

  bool tryReadFromFile(String filename) {
    bool ans;
    try {
      readFromFile(filename);
      ans = true;
    } catch(e) {
      ans = false;
    }
    return ans;
  }

  bool tryWriteToFile(String filename) {
    bool ans;
    try {
      readFromFile(filename);
      ans = true;
    } catch(e) {
      ans = false;
    }
    return ans;
  }
}
