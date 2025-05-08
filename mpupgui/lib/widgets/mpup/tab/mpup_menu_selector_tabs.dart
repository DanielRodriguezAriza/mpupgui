import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class TabData {
  final String name;
  final Widget widget;

  const TabData({
    required this.name,
    required this.widget,
  });
}

class MagickaPupTabSelector extends StatefulWidget {
  final List<TabData> tabs;

  const MagickaPupTabSelector({
    super.key,
    required this.tabs,
  });

  @override
  State<MagickaPupTabSelector> createState() => _MagickaPupTabSelectorState();
}

class _MagickaPupTabSelectorState extends State<MagickaPupTabSelector> {

  int currentTabIndex = 0;

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
                  children: getButtonsWidgets(),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: IndexedStack(
                index: currentTabIndex,
                children: getTabsWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTabsWidgets() {
    List<Widget> tabsWidgets = [];
    for(var tab in widget.tabs) {
      tabsWidgets.add(tab.widget);
    }
    return tabsWidgets;
  }

  List<Widget> getButtonsWidgets() {
    List<Widget> buttonsWidgets = [];
    int idx = 0;
    for(var tab in widget.tabs) {
      buttonsWidgets.add(getButtonWidget(idx, tab));
      ++idx;
    }
    return buttonsWidgets;
  }

  Widget getButtonWidget(int index, TabData tabData) {
    return Expanded(
      child: MagickaPupButton(
        onPressed: (){
          setState(() {
            currentTabIndex = index;
          });
        },
        level: 2,
        child: MagickaPupText(
          text: tabData.name,
          isBold: true,
          fontSize: 20,
        ),
      ),
    );
  }
}
