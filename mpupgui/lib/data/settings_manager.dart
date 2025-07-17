import 'dart:convert';
import 'package:mpupgui/data/app_settings_data.dart';
import 'package:mpupgui/data/cache_manager.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

abstract final class SettingsManager {

  static const String settingsFile = "./data/mpupgui_settings.json";

  static void resetSettings() {
    // Write the default settings to the settings file
    AppSettingsData settingsData = AppSettingsData.getDefault();
    settingsData.tryWriteToFile(settingsFile);

    // Re-load the settings file
    loadSettings();
  }

  static void loadSettings() {
    AppSettingsData settingsData = AppSettingsData();
    settingsData.tryReadFromFile(settingsFile);

    LanguageManager.setLanguage(settingsData.language);
    ThemeManager.setTheme(settingsData.theme);
    MagickaPupManager.setMagickaPupPath(settingsData.pathToMagickaPup);
    ModManager.setPathToMagickCowModManager(settingsData.pathToMagickCowModManager);
    ModManager.setPathToMagickCowModManagerProxy(settingsData.pathToExecProxy);
    ModManager.setPathToInstalls(settingsData.pathToInstalls);
    ModManager.setPathToMods(settingsData.pathToMods);
    ModManager.setPathToProfiles(settingsData.pathToProfiles);
    CacheManager.setPathToCache(settingsData.pathToCache);
  }

  static void saveSettings() {
    AppSettingsData settingsData = AppSettingsData();

    settingsData.language = LanguageManager.getLanguage();
    settingsData.theme = ThemeManager.getTheme();
    settingsData.pathToMagickaPup = MagickaPupManager.getMagickaPupPath();
    settingsData.pathToMagickCowModManager = ModManager.getPathToMagickCowModManager();
    settingsData.pathToExecProxy = ModManager.getPathToMagickCowModManagerProxy();
    settingsData.pathToInstalls = ModManager.getPathToInstalls();
    settingsData.pathToMods = ModManager.getPathToMods();
    settingsData.pathToProfiles = ModManager.getPathToProfiles();
    settingsData.pathToCache = CacheManager.getPathToCache();

    settingsData.writeToFile(settingsFile);
  }
}
