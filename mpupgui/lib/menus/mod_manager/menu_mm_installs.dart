import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:watcher/watcher.dart';

class ModManagerMenuInstalls extends StatefulWidget {
  const ModManagerMenuInstalls({super.key});

  @override
  State<ModManagerMenuInstalls> createState() => _ModManagerMenuInstallsState();
}

class _ModManagerMenuInstallsState extends State<ModManagerMenuInstalls> {

  final ScrollController controller = ScrollController();
  List<String> installs = [];

  @override
  void initState() {
    super.initState();
    loadInstalls();
  }

  bool isValidMagickaInstall(Directory directory) {
    var entryFiles = directory.listSync().whereType<File>();
    for(var entryFile in entryFiles) {
      if(pathName(entryFile.path) == "Magicka.exe") {
        return true;
      }
    }
    return false;
  }

  // NOTE : We can either iterate all entries and just say if(entry is Directory)
  // or use the .whereType<T>() function to filter and get only the entries that are of the specified type.
  void loadInstalls() {
    setState(() {
      installs.clear();
    });
    var dir = Directory(ModManager.pathToInstalls);
    if(dir.existsSync()) {
      var entries = dir.listSync().whereType<Directory>();
      for(var entry in entries) {
        if(isValidMagickaInstall(entry)) {
          setState(() {
            installs.add(pathName(entry.path));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        level: 0,
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                height: 60,
                text: "Actions",
                level: 2,
                child: Row(
                  children: getActionButtonWidgets(),
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Installs",
                level: 2,
                child: MagickaPupScroller(
                  controller: controller,
                  children: getInstallsWidgets(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getActionButtonWidget(String text, Function? action) {
    return Expanded(
      child: MagickaPupButton(
        onPressed: (){
          if(action != null) {
            action();
          }
        },
        child: MagickaPupText(
          text: text,
        ),
      ),
    );
  }

  List<Widget> getActionButtonWidgets() {
    return [
      getActionButtonWidget("Add new Install", null),
      getActionButtonWidget("Open Installs Directory", null),
      getActionButtonWidget("Refresh", loadInstalls),
    ];
  }

  List<Widget> getInstallsWidgets() {
    List<Widget> ans = [];
    for(var install in installs) {
      ans.add(getInstallWidget(install));
    }
    return ans;
  }

  Widget getInstallWidget(String install) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: MagickaPupContainer(
          level: 1,
          child: Row(
            children: [
              Expanded(
                // flex: 9,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: MagickaPupText(
                    isBold: true,
                    text: install,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: MagickaPupButton(
                  level: 0,
                  useAutoPadding: false,
                  onPressed: (){},
                  child: const MagickaPupText(
                    text: "...",
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
