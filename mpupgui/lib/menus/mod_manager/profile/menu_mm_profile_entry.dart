import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/game_profile_data.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/menus/mod_manager/profile/widget_install_entry.dart';
import 'package:mpupgui/menus/mod_manager/profile/widget_mod_entry.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/utility/math_util.dart';
import 'package:mpupgui/utility/popup_util.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_fs_view.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';
import 'package:open_filex/open_filex.dart';
import 'package:watcher/watcher.dart';

class ModManagerMenuProfileEntry extends StatefulWidget {

  final String path;
  final bool isNew;
  final Function? onApply;
  final Function? onCancel;

  const ModManagerMenuProfileEntry({
    super.key,
    required this.path,
    required this.isNew,
    this.onApply,
    this.onCancel,
  });

  @override
  State<ModManagerMenuProfileEntry> createState() => _ModManagerMenuProfileEntryState();
}

class ModData {
  late bool selected;
  late int loadOrder;

  ModData({
    this.selected = false,
    this.loadOrder = 0,
  });
}

class _ModManagerMenuProfileEntryState extends State<ModManagerMenuProfileEntry> {

  // Controllers
  TextEditingController controllerProfileName = TextEditingController();

  ScrollController controllerScrollInstalls = ScrollController();
  ScrollController controllerScrollMods = ScrollController();

  // Variables
  List<String> foundInstalls = [];
  List<String> foundMods = [];

  String selectedInstall = "";
  Map<String, ModData> modData = {};

  @override
  void initState() {
    super.initState();

    loadInstalls();
    loadMods();

    if(widget.isNew) {
      // Create a new profile and begin editing
      controllerProfileName.text = "New Profile";
    } else {
      // Load data from the selected profile and begin editing
      GameProfileData data = GameProfileData();
      data.tryReadFromFile(pathJoin(widget.path, "profile.json"));
      controllerProfileName.text = data.name;
      selectedInstall = data.install;
      var selectedMods = data.mods.toList(); // Make a copy of the list of mods.
      for(int index = 0; index < selectedMods.length; ++index) {
        modData[selectedMods[index]] = ModData(loadOrder: index, selected: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return MagickaPupBackground(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: MagickaPupText(
              text: widget.isNew ? "Create Profile" : "Edit Profile",
              fontSize: 30,
              isBold: true,
            ),
          ),
          Expanded(
            child: MagickaPupContainer(
              // text: "Profile Configuration",
              level: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: MagickaPupText(
                              text: "Profile Name",
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: MagickaPupTextField(
                                controller: controllerProfileName,
                                onEdit: (){},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: MagickaPupContainer(
                            text: "Base Install",
                            child: getInstalls(context),
                          ),
                        ),
                        Expanded(
                          child: MagickaPupContainer(
                            text: "Mods",
                            child: getMods(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          IntrinsicHeight(
            child: MagickaPupContainer(
              height: 60,
              // text: "Actions",
              level: 2,
              child: Row(
                children: [
                  Expanded(
                    child: MagickaPupButton(
                        onPressed: (){
                          cancelChanges(context);
                        },
                        child: MagickaPupText(
                          text: "Cancel",
                        )
                    ),
                  ), // Cancel button
                  Expanded(
                    child: MagickaPupButton(
                      onPressed: (){
                        applyChanges(context);
                      },
                      child: MagickaPupText(
                          text: "Apply Changes"
                      ),
                    ),
                  ), // Accept button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // region Installs

  void loadInstalls() {
    setState(() {
      foundInstalls.clear();
    });
    Directory dir = Directory(ModManager.getPathToInstalls());
    var childDirs = dir.listSync().whereType<Directory>();
    for(var childDir in childDirs) {
      for(var file in childDir.listSync().whereType<File>()) {
        final String name = pathName(file.path, true);
        if(name.toLowerCase() == "magicka.exe") {
          setState(() {
            foundInstalls.add(pathName(childDir.path));
          });
        }
      }
    }
  }

  Widget getInstalls(BuildContext context) {
    return MagickaPupScroller(
      controller: controllerScrollInstalls,
      children: getInstallEntries(),
    );
  }

  List<Widget> getInstallEntries() {
    List<Widget> ans = [];
    for(var install in foundInstalls) {
      ans.add(getInstallEntry(install));
    }
    return ans;
  }

  Widget getInstallEntry(String install) {
    return InstallEntryWidget(
      text: install,
      path: install,
      selected: selectedInstall == install,
      onSelected: (){
        selectInstall(install);
      }
    );
  }

  void selectInstall(String name) {
    setState(() {
      selectedInstall = name;
    });
  }

  // endregion

  // region Mods

  void loadMods() {
    setState(() {
      foundInstalls.clear();
    });
    Directory dir = Directory(ModManager.getPathToMods());
    var childDirs = dir.listSync().whereType<Directory>();
    setState(() {
      foundMods = childDirs.map((d)=>pathName(d.path)).toList();
    });
  }

  Widget getMods(BuildContext context) {
    return MagickaPupFileSystemView(
      path: ModManager.getPathToMods(),
      filter: (FileSystemEntity entry) {
        return true;
      },
      widgetConstructor: getModEntry,
    );
  }

  Widget getModEntry(FileSystemEntity entry) {
    final String name = pathName(entry.path);
    return ModEntryWidget(
      text: name,
      path: entry.path,
      selected: modData.containsKey(name) && modData[name]!.selected,
      onSelected: (){
        selectMod(name);
      },
      loadOrder: modData.containsKey(name) ? modData[name]!.loadOrder : 0,
    );
  }

  void selectMod(String name) {

    if(!modData.containsKey(name)) {
      modData[name] = ModData(selected: false, loadOrder: 0);
    }

    // Logic to enable / disable a mod
    setState(() {
      modData[name]!.selected = !(modData[name]!.selected);
    });
  }

  // endregion

  // region Profile Editing Actions

  void cancelChanges(BuildContext context) {
    // Do nothing else for now...
    if(widget.onCancel != null) {
      widget.onCancel!();
    }
  }

  void applyChanges(BuildContext context) {
    // TODO : Implement additional logic
    bool successfullyAppliedChanges = false;
    if(widget.isNew) {
      // Create new profile
      successfullyAppliedChanges = createProfile(context);
    } else {
      // Edit the currently selected profile
      successfullyAppliedChanges = editProfile();
    }

    if(successfullyAppliedChanges) {
      // Additional exit logic goes here.
      if(widget.onApply != null) {
        widget.onApply!();
      }
    } else {
      // Display error pop up to notify that we could not apply the changes

      // TODO : Improve the error messages by using some proper error handling
      // eg: use exceptions and whatnot, and then catching and reading out the
      // exception messages...
      // basically just implement a way to see why the fuck is it that we cannot
      // really apply the changes we've just made...

      // Show the popup dialogue
      showPopUpError(
        context: context,
        title: "Failed to Apply Changes!",
        description: "Could not apply the specified changes to the profile!",
      );
    }
  }

  bool createProfile(BuildContext context) {
    bool ans;
    try {
      String basePath = ModManager.getPathToProfiles();
      String dirName = "${ModManager.getNextProfileDirNumber()}";

      String profileDirPath = pathJoin(basePath, dirName);
      Directory profileDir = Directory(profileDirPath);
      profileDir.createSync();

      String profileFilePath = pathJoin(profileDirPath, "profile.json");
      var profileData = getProfileData();
      profileData.writeToFile(profileFilePath);

      ans = true; // success
    } catch(e) {
      // If something goes wrong during profile creation, when then bail out and notify that we did not create the profile properly.
      ans = false; // failure
    }
    return ans;
  }

  bool editProfile() {
    bool ans;
    try {
      String filePath = pathJoin(widget.path, "profile.json");

      var profileData = getProfileData();
      profileData.writeToFile(filePath);

      ans = true; // success;
    } catch(e) {
      ans = false; // failure
    }
    return ans;
  }

  GameProfileData getProfileData() {
    GameProfileData profileData = GameProfileData();
    profileData.name = controllerProfileName.text;
    profileData.install = selectedInstall;
    List<String> selectedMods = [];
    for(var modName in modData.keys) {
      if(modData[modName]!.selected) {
        selectedMods.add(modName);
      }
    }
    profileData.mods = selectedMods;
    return profileData;
  }

  // endregion
}
