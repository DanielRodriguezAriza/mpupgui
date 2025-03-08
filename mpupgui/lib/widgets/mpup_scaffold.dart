import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/menu_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_container.dart';

class MagickaPupScaffold extends StatelessWidget {

  final Widget child;

  const MagickaPupScaffold({
    super.key,
    required this.child,
  });

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
                  getTabButton(context, "/compiler", "loc_decompiler"),
                  getTabButton(context, "/decompiler", "loc_compiler"),
                  getTabButton(context, "/settings", "loc_settings"),
                ],
              )
          ),
        ),
        backgroundColor: ThemeManager.getColorImage(0),
        body: MagickaPupContainer(
          child: child
        )
    );
  }

  Widget getTabButton(BuildContext context, String pathString, String locString) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: MagickaPupButton(
              colorIndex: 2,
              sizeX: 150,
              text: LanguageManager.getString(locString),
              onPressed: (){
                setTab(context, pathString);
              }
          ),
        )
    );
  }

  void setTab(BuildContext context, String pathString) {
    MenuManager.loadMenu(context, pathString);
  }
}
