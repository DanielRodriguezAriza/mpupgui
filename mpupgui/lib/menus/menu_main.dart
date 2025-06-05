import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_home.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_installs.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_mods.dart';
import 'package:mpupgui/menus/mod_manager/profile/menu_mm_profile_entry.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_profiles.dart';
import 'package:mpupgui/widgets/mpup/tab/mpup_tab_selector.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    // return const MagickaPupFileProcessorMenuGeneric();
    return const MagickaPupTabSelector(
        tabsHeight: 45,
        isBold: true,
        tabs: [
          TabData(
            name: "Home",
            widget: HomeMenu(),
          ),
          TabData(
            name: "Installs",
            widget: ModManagerMenuInstalls(),
            rebuildOnEnter: true,
          ),
          TabData(
            name: "Mods",
            widget: ModManagerMenuMods(),
            rebuildOnEnter: true,
          ),
          TabData(
            name: "Profiles",
            widget: ModManagerMenuProfiles(),
            rebuildOnEnter: true,
          ),
          TabData(
            name: "Compiler",
            widget: CompilerMenu(),
          ),
          TabData(
            name: "Decompiler",
            widget: DecompilerMenu(),
          ),
          TabData(
            name: "Settings",
            widget: SettingsMenu(),
            // rebuildOnEnter: true,
          ),
        ]
    );
  }
}
