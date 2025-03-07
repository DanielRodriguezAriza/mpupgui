import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/widgets/menu_scaffold.dart';
import 'package:mpupgui/widgets/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_file_processor.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

import '../data/menu_manager.dart';
import '../data/theme_manager.dart';
import '../widgets/mpup_button.dart';

// TODO : Get rid of this maybe? Or make this a "what's new" kind of screen.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String currentTab = "loc_decompiler";

  void setTab(String newTab) {
    setState(() {
      currentTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.getColorImage(0),
        title: MagickaPupContainer(
            paddingParent: 0,
            sizeY: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getTabButton("loc_decompiler"),
                getTabButton("loc_compiler"),
                getTabButton("loc_settings"),
              ],
            )
        ),
      ),
      backgroundColor: ThemeManager.getColorImage(0),
      body: MagickaPupContainer(
        // child: MagickaPupText(text: "The tab is : $currentTab")
        child: getTabWindow(currentTab)
      )
    );
  }

  Widget getTabButton(String tabLoc) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
        child: MagickaPupButton(colorIndex: 2, sizeX: 150, text: LanguageManager.getString(tabLoc), onPressed: (){setTab(tabLoc);}),
      )
    );
  }

  Widget getTabWindow(String tabLoc) {
    switch(tabLoc) {
      case "loc_decompiler": {
        return const DecompilerMenu();
      }
      case "loc_compiler": {
        return const CompilerMenu();
      }
      case "loc_settings" : {
        return const SettingsMenu();
      }
    }
    return MagickaPupText(text: "The path \"$tabLoc\" does not exist!");
  }
}

/*
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("MagickaPUP GUI"),
            actions: [
              IconButton(
                  onPressed: () {
                    MenuManager.setMenu(1);
                  },
                  icon: Text("Decompile")
              ),
              IconButton(
                  onPressed: () {  },
                  icon: Text("Compile")
              ),
              IconButton(
                  onPressed: () {  },
                  icon: Text("Run All")
              )
            ]
        ),
      body: Container(
        child: Row(
          children: [
            MenuManager.getMenu(),
            const Text("test"),
            MagickaPupButton(
              text: 'Decompiler',
              onPressed: (){},
              sizeX: 150
            ),
            MagickaPupButton(
              text: 'Compiler',
              onPressed: (){},
              sizeX: 150
            ),
            MagickaPupButton(
              text: 'Settings',
              onPressed: (){},
              sizeX: 150
            )
          ],
        )
      ),
    );
  }
}
*/
