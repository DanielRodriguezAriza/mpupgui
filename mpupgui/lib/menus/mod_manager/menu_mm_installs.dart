import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';
import 'package:mpupgui/utility/file_handling.dart';

class ModManagerMenuInstalls extends StatelessWidget {
  const ModManagerMenuInstalls({super.key});

  @override
  Widget build(BuildContext context) {
    return ModManagerMenuGenericListDisplay(
      name: "Installs",
      directoryFilter: directoryFilter,
      directoryGetter: directoryGetter
    );
  }

  bool directoryFilter(Directory directory) {
    var entryFiles = directory.listSync().whereType<File>();
    for(var entryFile in entryFiles) {
      if(pathName(entryFile.path) == "Magicka.exe") {
        return true;
      }
    }
    return false;
  }

  String directoryGetter() {
    return ModManager.getPathToInstalls();
  }
}
