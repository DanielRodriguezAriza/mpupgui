import 'dart:convert';
import 'package:mpupgui/data/app_settings_data.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

abstract final class SettingsManager {

  static const String settingsFile = "./mpupgui_settings.json";

  static void loadSettings() {
    AppSettingsData settingsData = AppSettingsData();
    settingsData.readFromFile(settingsFile);

    LanguageManager.setLanguage(settingsData.language);
    ThemeManager.setTheme(settingsData.theme);
    MagickaPupManager.setMagickaPupPath(settingsData.pathToMagickaPup);
    ModManager.setPathToMagickCowModManager(settingsData.pathToMagickCowModManager);
    ModManager.setPathToInstalls(settingsData.pathToInstalls);
    ModManager.setPathToMods(settingsData.pathToMods);
    ModManager.setPathToProfiles(settingsData.pathToProfiles);
  }

  static void saveSettings() {
    AppSettingsData settingsData = AppSettingsData();

    settingsData.language = LanguageManager.getLanguage();
    settingsData.theme = ThemeManager.getTheme();
    settingsData.pathToMagickaPup = MagickaPupManager.getMagickaPupPath();
    settingsData.pathToMagickCowModManager = ModManager.getPathToMagickCowModManager();
    settingsData.pathToInstalls = ModManager.getPathToInstalls();
    settingsData.pathToMods = ModManager.getPathToMods();
    settingsData.pathToProfiles = ModManager.getPathToProfiles();

    settingsData.writeToFile(settingsFile);
  }
}
