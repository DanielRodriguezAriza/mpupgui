import 'dart:convert';
import 'dart:io';

import 'package:mpupgui/utility/file_handling.dart';

class GameProfileData {
  late String name;
  late String install;
  late List<String> mods;

  GameProfileData({
    this.name = "",
    this.install = "",
    this.mods = const [],
  });

  void loadFromFile(String path) {
    try {
      String contents = readStringFromFile(path);
      var dict = jsonDecode(contents);
      name = dict["Name"];
      install = dict["Install"];
      mods = dict["Mods"];
    } catch(e) {
      // Do Nothing.
    }
  }

  void saveToFile(String path) {
    try {
      var dict = {
        "Name": name,
        "Install": install,
        "Mods": mods,
      };
      String contents = jsonEncode(dict);
      writeStringToFile(path, contents);
    } catch(e) {
      // Do Nothing.
    }
  }
}
