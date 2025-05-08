import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup_button.dart';

class MagickaPupMenuSelectorTabsMenu extends StatefulWidget {
  const MagickaPupMenuSelectorTabsMenu({super.key});

  @override
  State<MagickaPupMenuSelectorTabsMenu> createState() => _MagickaPupMenuSelectorTabsMenuState();
}

class _MagickaPupMenuSelectorTabsMenuState extends State<MagickaPupMenuSelectorTabsMenu> {

  int menuIndex = 0;

  final SettingsMenu settingsMenu = const SettingsMenu();
  final MagickaPupFileProcessorMenuGeneric compilerMenu = const MagickaPupFileProcessorMenuGeneric();

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            Expanded(
              child: MagickaPupBackground(
                level: 1,
                child: getButtons(),
              ),
            ),
            Expanded(
              flex: 9,
              child: IndexedStack(
                index: menuIndex,
                children: [
                  settingsMenu,
                  compilerMenu,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getButtons() {
    List<Widget> generatedButtons = [
      getButton("menu A", 0),
      getButton("menu B", 1),
    ];
    return Row(
      children: generatedButtons,
    );
  }

  Widget getButton(String text, int index, [int flex = 1]) {
    return Expanded(
      flex: flex,
      child: MagickaPupButton(
        text: text,
        colorIndex: 2,
        onPressed: (){
          setState(() {
            menuIndex = index;
            // print("changing menu to $index");
          });
        },
      ),
    );
  }
}
