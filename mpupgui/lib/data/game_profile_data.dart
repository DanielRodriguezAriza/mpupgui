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

  void readFromFile(String path) {
    String contents = readStringFromFile(path);
    var dict = jsonDecode(contents);
    name = dict["Name"];
    install = dict["Install"];
    mods = List<String>.from(dict["Mods"].map((mod)=>mod));
  }

  void writeToFile(String path) {
    var dict = {
      "Name": name,
      "Install": install,
      "Mods": mods,
    };
    String contents = jsonEncode(dict);
    writeStringToFile(path, contents);
  }

  bool tryReadFromFile(String path) {
    bool ans;
    try {
      readFromFile(path);
      ans = true;
    } catch(e) {
      // Do Nothing.
      print(e);
      ans = false;
    }
    return ans;
  }

  bool tryWriteToFile(String path) {
    bool ans;
    try {
      writeToFile(path);
      ans = true;
    } catch(e) {
      // Do Nothing.
      print(e);
      ans = false;
    }
    return ans;
  }
}
