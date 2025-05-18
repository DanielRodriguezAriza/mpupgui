import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/game_profile_data.dart';
import 'package:mpupgui/data/menu_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_profile_entry.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/utility/popup_util.dart';
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
  late String selectedProfilePath;
  late bool selectedProfileIsNew;

  @override
  Widget build(BuildContext context) {
    if(menuIndex == 0) {
      return getProfileListMenu();
    } else {
      return getProfileEntryMenu();
    }
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
          action: (){
            createProfile(context, "NewProfile"); // TODO : Add system to get the new profile name with added numbers at the end if "NewProfile" is already taken.
          },
        ),
      ],
    );
  }

  Widget getProfileEntryMenu() {
    return ModManagerMenuProfileEntry(
      path: selectedProfilePath,
      isNew: selectedProfileIsNew,
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
    GameProfileData profileData = GameProfileData();
    profileData.loadFromFile(pathJoin(path, "profile.json"));
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
                    text: profileData.name,
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
                      editProfile(context, path);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () {
                      showPopUp(
                        context: context,
                        title: "Warning!",
                        description: "Are you sure you want to delete the profile \"$name\"?",
                        onAccept: (){
                          deleteProfile(path);
                        },
                      );
                    },
                    child: const MagickaPupText(
                      text: "X",
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

  void createProfile(BuildContext context, String name) {
    selectedProfilePath = name;
    selectedProfileIsNew = true;
    setState(() {
      menuIndex = 1;
    });
  }

  void editProfile(BuildContext context, String name) {
    selectedProfilePath = name;
    selectedProfileIsNew = false;
    setState(() {
      menuIndex = 1;
    });
  }

  void deleteProfile(String path) {
    Directory dir = Directory(path);
    if(dir.existsSync()) {
      dir.deleteSync(recursive: true); // Recursive set to true so that elements within the directory can be deleted as well.
    }
  }
}
