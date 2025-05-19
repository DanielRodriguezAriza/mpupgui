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

  bool loadFromFile(String path) {
    bool ans;
    try {
      String contents = readStringFromFile(path);
      var dict = jsonDecode(contents);
      name = dict["Name"];
      install = dict["Install"];
      mods = List<String>.from(dict["Mods"].map((mod)=>mod));
      ans = true;
    } catch(e) {
      // Do Nothing.
      print(e);
      ans = false;
    }
    return ans;
  }

  bool saveToFile(String path) {
    bool ans;
    try {
      var dict = {
        "Name": name,
        "Install": install,
        "Mods": mods,
      };
      String contents = jsonEncode(dict);
      writeStringToFile(path, contents);
      ans = true;
    } catch(e) {
      // Do Nothing.
      print(e);
      ans = false;
    }
    return ans;
  }
}
