import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_profile_entry.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:open_filex/open_filex.dart';

class ModManagerMenuProfiles extends StatefulWidget {
  const ModManagerMenuProfiles({super.key});

  @override
  State<ModManagerMenuProfiles> createState() => _ModManagerMenuProfilesState();
}

class _ModManagerMenuProfilesState extends State<ModManagerMenuProfiles> {

  int menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: menuIndex,
      children: [
        getProfileListMenu(),
        getProfileEntryMenu(),
      ],
    );
  }

  Widget getProfileListMenu() {
    return ModManagerMenuGenericListDisplay(
      name: "Profiles",
      directoryFilter: directoryFilter,
      directoryGetter: directoryGetter,
      widgetConstructor: getEntryWidget,
      additionalButtons: [
        ModManagerMenuGenericListDisplayAction(
          name: "Add new Profile",
          action: createProfile,
        ),
      ],
    );
  }

  Widget getProfileEntryMenu() {
    return ModManagerMenuProfileEntry(
      onApply: (){
        setState(() {
          menuIndex = 0;
        });
      },
      onCancel: (){
        setState(() {
          menuIndex = 0;
        });
      },
    );
  }

  bool directoryFilter(Directory dir) {
    var files = dir.listSync().whereType<File>();
    for(var file in files) {
      if(pathName(file.path, true).toLowerCase() == "profile.json") {
        return true;
      }
    }
    return false;
  }

  String directoryGetter() {
    return ModManager.getPathToProfiles();
  }

  Widget getEntryWidget(String name, String path) {
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: MagickaPupText(
                    isBold: true,
                    text: name,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () async {
                      await Process.start(pathJoinMany([path, "game", "Magicka.exe"]), []); // Open the game
                    },
                    child: const MagickaPupText(
                      text: "P",
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () async {
                      editProfile();
                    },
                    child: const MagickaPupText(
                      text: "E",
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () async {
                      await OpenFilex.open(path);
                    },
                    child: const MagickaPupText(
                      text: "O",
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createProfile() {
    setState(() {
      menuIndex = 1;
    });
  }

  void editProfile() {
    setState(() {
      menuIndex = 1;
    });
  }
}
