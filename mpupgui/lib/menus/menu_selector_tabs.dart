import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup_button.dart';

class MenuData {
  final String name;
  final Widget widget;

  const MenuData({
    required this.name,
    required this.widget,
  });
}

class MagickaPupMenuSelectorTabsMenu extends StatefulWidget {
  const MagickaPupMenuSelectorTabsMenu({super.key});

  @override
  State<MagickaPupMenuSelectorTabsMenu> createState() => _MagickaPupMenuSelectorTabsMenuState();
}

class _MagickaPupMenuSelectorTabsMenuState extends State<MagickaPupMenuSelectorTabsMenu> {

  int currentMenuIndex = 0;

  final List<MenuData> menuDataCache = const [
    MenuData(
      name: "Settings",
      widget: SettingsMenu(),
    ),
    MenuData(
      name: "Compiler",
      widget: MagickaPupFileProcessorMenuGeneric(),
    ),
  ];

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
                child: Row(
                  children: getButtonWidgets(),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: IndexedStack(
                index: currentMenuIndex,
                children: getMenuWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getMenuWidgets() {
    List<Widget> generatedMenuWidgets = [];
    for(var menu in menuDataCache) {
      generatedMenuWidgets.add(menu.widget);
    }
    return generatedMenuWidgets;
  }

  List<Widget> getButtonWidgets() {
    List<Widget> generatedButtons = [];
    int idx = 0;
    for(var menu in menuDataCache) {
      generatedButtons.add(getButtonWidget(idx, menu));
      ++idx;
    }
    return generatedButtons;
  }

  Widget getButtonWidget(int index, MenuData menuData) {
    return Expanded(
      child: MagickaPupButton(
        text: menuData.name,
        colorIndex: 2,
        onPressed: (){
          setState(() {
            currentMenuIndex = index;
            // print("changing menu to $index");
          });
        },
      ),
    );
  }
}
