import 'dart:convert';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

class AppSettingsData {

  // App Config
  late Language language;
  late AppTheme theme;

  // Tools
  late String pathToMagickaPup;
  late String pathToMagickCowModManager;
  late String pathToExecProxy;

  // Mod Manager
  late String pathToInstalls;
  late String pathToMods;
  late String pathToProfiles;

  // Other
  late String pathToCache;

  T? _loadValueRaw<T>(var dict, String path) {
    try {
      T ans = dict[path];
      return ans;
    } catch(e) {
      // print("AppSettingsData._loadValue() has failed : $e");
      return null;
    }
  }

  T _loadValue<T>(var dict, String path, T defaultValue) {
    return _loadValueRaw(dict, path) ?? defaultValue;
  }

  static AppSettingsData getDefault() {
    AppSettingsData ans = AppSettingsData();

    ans.language = Language.english;
    ans.theme = AppTheme.dark;

    ans.pathToMagickaPup = "data/tools/mpup/MagickaPUP.exe";
    ans.pathToMagickCowModManager = "data/tools/mcow-mm/MagickCowModManager.exe";
    ans.pathToExecProxy = "data/tools/execp/ExecProxy.exe";

    ans.pathToInstalls = "data/mm/installs";
    ans.pathToMods = "data/mm/mods";
    ans.pathToProfiles = "data/mm/profiles";

    ans.pathToCache = "data/cache";

    return ans;
  }

  void readFromFile(String settingsFile) {
    var str = readStringFromFile(settingsFile);
    var data = jsonDecode(str);
    readFromDict(data);
  }

  void readFromDict(var data) {
    // Generate default values for failed reads
    var defaultValues = getDefault();

    // Load Language
    String languageStr = _loadValue(data, "Language", defaultValues.language.name);
    language = Language.values.byName(languageStr);

    // Load App Theme
    String themeStr = _loadValue(data, "Theme", defaultValues.theme.name);
    theme = AppTheme.values.byName(themeStr);

    // Load MagickaPup Path
    pathToMagickaPup = _loadValue(data, "MagickaPupPath", defaultValues.pathToMagickaPup);

    // Load MagickCow mod manager Path
    pathToMagickCowModManager = _loadValue(data, "MagickCowModManagerPath", defaultValues.pathToMagickCowModManager);

    // Load ExecProxy Path
    pathToExecProxy = _loadValue(data, "ExecProxyPath", defaultValues.pathToExecProxy);

    // Load path to installs
    pathToInstalls = _loadValue(data, "pathToInstalls", defaultValues.pathToInstalls);

    // Load path to mods
    pathToMods = _loadValue(data, "pathToMods", defaultValues.pathToMods);

    // Load path to profiles
    pathToProfiles = _loadValue(data, "pathToProfiles", defaultValues.pathToProfiles);

    // Load path to cache
    pathToCache = _loadValue(data, "pathToCache", defaultValues.pathToCache);
  }

  void writeToFile(String settingsFile) {
    Map<String, dynamic> data = {
      "Language" : language.name,
      "Theme" : theme.name,
      "MagickaPupPath" : pathToMagickaPup,
      "MagickCowModManagerPath" : pathToMagickCowModManager,
      "ExecProxyPath" : pathToExecProxy,
      "pathToInstalls" : pathToInstalls,
      "pathToMods" : pathToMods,
      "pathToProfiles" : pathToProfiles,
      "pathToCache" : pathToCache,
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
      readFromDict(null); // Hacky workaround to get default settings loaded
      ans = false;
    }
    return ans;
  }

  bool tryWriteToFile(String filename) {
    bool ans;
    try {
      writeToFile(filename);
      ans = true;
    } catch(e) {
      ans = false;
    }
    return ans;
  }
}
