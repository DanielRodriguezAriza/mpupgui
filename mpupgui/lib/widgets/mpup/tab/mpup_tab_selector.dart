import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class TabData {
  final String name;
  final Widget widget;
  final bool rebuildOnEnter;

  const TabData({
    required this.name,
    required this.widget,
    this.rebuildOnEnter = false,
  });
}

class MagickaPupTabSelector extends StatefulWidget {
  final List<TabData> tabs;
  final double? tabsHeight;
  final double fontSize;
  final bool isBold;

  const MagickaPupTabSelector({
    super.key,
    required this.tabs,
    this.tabsHeight,
    this.fontSize = 18,
    this.isBold = false,
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
    var children = widget.tabsHeight == null ? [
      Expanded(
        child: getUpperSection(),
      ),
      Expanded(
        flex: 9,
        child: getLowerSection(),
      ),
    ] : [
      SizedBox(
        height: widget.tabsHeight,
        child: getUpperSection(),
      ),
      Expanded(
        child: getLowerSection(),
      ),
    ];
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget getUpperSection() {
    return MagickaPupBackground(
      level: 1,
      child: Row(
        children: getButtonsWidgets(),
      ),
    );
  }

  Widget getLowerSection() {
    return IndexedStack(
      index: currentTabIndex,
      children: getTabsWidgets(),
    );
  }

  List<Widget> getTabsWidgets() {
    List<Widget> tabsWidgets = [];
    int idx = 0;
    for(var tab in widget.tabs) {
      if(tab.rebuildOnEnter && currentTabIndex != idx) {
        tabsWidgets.add(const Placeholder());
      }
      else {
        tabsWidgets.add(tab.widget);
      }
      ++idx;
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
        level: currentTabIndex == index ? 3 : 2,
        child: MagickaPupText(
          text: tabData.name,
          isBold: widget.isBold,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }
}
