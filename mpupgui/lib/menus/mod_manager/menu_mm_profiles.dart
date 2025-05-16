import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';
import 'package:mpupgui/utility/file_handling.dart';

class ModManagerMenuProfiles extends StatelessWidget {
  const ModManagerMenuProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return ModManagerMenuGenericListDisplay(
      name: "Profiles",
      directoryFilter: directoryFilter,
      directoryGetter: directoryGetter,
      widgetConstructor: getEntryWidget,
      additionalButtons: [
        ModManagerMenuGenericListDisplayAction(
          name: "Add new Profile",
          action: addNewProfile,
        ),
      ],
    );
  }

  bool directoryFilter(Directory dir) {
    var files = dir.listSync().whereType<File>();
    for(var file in files) {
      if(pathName(file.path).toLowerCase() == "profile.json") {
        return true;
      }
    }
    return false;
  }

  String directoryGetter() {
    return ModManager.getPathToProfiles();
  }

  Widget getEntryWidget(String name, String path) {
    return const Placeholder();
  }

  void addNewProfile() {
    
  }
}
