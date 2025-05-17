import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_installs.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_mods.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_profile_entry.dart';
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
            name: "Installs",
            widget: ModManagerMenuInstalls(),
          ),
          TabData(
            name: "Mods",
            widget: ModManagerMenuMods(),
          ),
          TabData(
            name: "Profiles",
            widget: ModManagerMenuProfiles(),
          ),
          TabData(
            name: "Compiler",
            widget: MagickaPupFileProcessorMenuGeneric(
              extensions: ["json", "png"], // NOTE : The compiler can try to compile any type of asset. We could leave it at that for now, but in the future maybe it would make sense to limit it to formats that mpup actually understands? but with this, it becomes far more trivial to maintain these 2 programs as separate, since updates to compiler support should not affect functionality of the gui. We'll see what I do in the end idk. Anyway, for now, I'm adding json and png and then we'll add more stuff or we'll get rid of this shit idk...
            ),
          ),
          TabData(
            name: "Decompiler",
            widget: MagickaPupFileProcessorMenuGeneric(
              extensions: ["xnb"],
            ),
          ),
          TabData(
            name: "Settings",
            widget: SettingsMenu(),
          ),
        ]
    );
  }
}
