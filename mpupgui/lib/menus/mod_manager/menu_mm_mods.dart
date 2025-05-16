import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';

class ModManagerMenuMods extends StatelessWidget {
  const ModManagerMenuMods({super.key});

  @override
  Widget build(BuildContext context) {
    return ModManagerMenuGenericListDisplay(
      name: "Mods",
      directoryFilter: directoryFilter,
      directoryGetter: directoryGetter
    );
  }

  bool directoryFilter(Directory directory) {
    return true; // For now, always return that the dir is valid. Maybe in the future check for modinfo.txt or something.
  }

  String directoryGetter() {
    return ModManager.getPathToMods();
  }
}
