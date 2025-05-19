import 'dart:io';

import 'package:mpupgui/utility/file_handling.dart';

abstract final class ModManager {
  // region Mod Manager Config / Paths

  static String pathToInstalls = "./installs";
  static String pathToMods = "./mods";
  static String pathToProfiles = "./profiles";

  static void setPathToInstalls(String path) {
    pathToInstalls = path;
  }

  static void setPathToMods(String path) {
    pathToMods = path;
  }

  static void setPathToProfiles(String path) {
    pathToProfiles = path;
  }

  static String getPathToInstalls() {
    return pathToInstalls;
  }

  static String getPathToMods() {
    return pathToMods;
  }

  static String getPathToProfiles() {
    return pathToProfiles;
  }

  // endregion

  // region Runtime Info

  static late String selectedProfileName;
  static late bool selectedProfileIsNew;

  static void setSelectedProfile(String name, bool isNew) {
    selectedProfileName = name;
    selectedProfileIsNew = isNew;
  }

  // endregion

  static int getLastProfileDirNumber() {
    try {
      String path = getPathToProfiles();
      Directory dir = Directory(path);
      var subdirs = dir.listSync().whereType<Directory>();
      List<int> numbers = [0]; // Always initialize the list with the value 0 just in case there are no profiles yet.
      for (var subdir in subdirs) {
        int? number = int.tryParse(pathName(subdir.path), radix: 10); // Force the radix to be 10. This way, numbers with trailing 0s are not read as octal, which would fuck shit up.
        if (number != null) {
          numbers.add(number);
        }
      }
      numbers.sort();
      return numbers[numbers.length - 1];
    } catch(e) {
      return -1; // Should never happen, but just in case...
    }
  }

  static int getNextProfileDirNumber() {
    return getLastProfileDirNumber() + 1; // lol, such a silly goose...
  }

}
