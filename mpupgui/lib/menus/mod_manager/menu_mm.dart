import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/tab/mpup_tab_selector.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenu extends StatelessWidget {
  const ModManagerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return const Scaffold(
      body: MagickaPupBackground(
        child: MagickaPupTabSelector(
          tabsHeight: 40,
          tabs: [
            TabData(
              name: "Profiles",
              widget: Placeholder(),
            ),
            TabData(
              name: "Base Installs",
              widget: Placeholder(),
            ),
            TabData(
              name: "Mods",
              widget: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}
