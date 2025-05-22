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

class EntryData {
  String name;
  String path;

  EntryData({
    required this.name,
    required this.path,
  });
}

class _ModManagerMenuProfileEntryState extends State<ModManagerMenuProfileEntry> {

  // Controllers
  TextEditingController controllerProfileName = TextEditingController();

  ScrollController controllerScrollInstalls = ScrollController();
  ScrollController controllerScrollMods = ScrollController();

  TextEditingController controllerPopUp = TextEditingController();

  // Variables
  String selectedInstall = "";
  List<EntryData> foundInstalls = [];

  // NOTE : Some weird SOA-like stuff going on here, I suppose...
  // List<int> modsOrder = []; // NOTE : Disabled and unused for now...
  List<bool> modsEnabled = [];
  // List<bool> modsExist = []; // NOTE : The idea was that if a mod was removed, then it would appear on red when editing a load order than still contemplated this mod.
  List<String> modsName = [];


  // region Initialization

  // Function to execute generic initialization logic.
  // Applies both to creating and editing a profile.
  void initMenuProfileGeneric() {
    // Load the list of available installs from the hard drive
    loadInstalls();

    // Load the list of available mods from the hard drive
    loadMods();
  }

  // Function with initialization logic when creating a new profile
  void initMenuProfileCreate() {
    // Create a new profile and begin editing

    // Assign the profile name to be "New Profile" or whatever language
    // specific name.
    controllerProfileName.text = "New Profile";

    // If any installs are available, select the first available install.
    if(foundInstalls.isNotEmpty) {
      selectedInstall = foundInstalls.first.name;
    }

    // NOTE : Do not select any mods to be loaded by default.
    // New profiles should always assume vanilla.
  }

  // Function with initialization logic when editing an existing profile
  void initMenuProfileEdit() {
    // Load data from the selected profile and begin editing
    GameProfileData data = GameProfileData();
    data.tryReadFromFile(pathJoin(widget.path, "profile.json"));

    // Load the name of the profile
    controllerProfileName.text = data.name;

    // Load the selected base install
    selectedInstall = data.install;

    // Load the enabled mods
    for(int modIndex = 0; modIndex < data.mods.length; ++modIndex) {
      final String mod = data.mods[modIndex];
      final int entryIndex = modsName.indexOf(mod);
      if(entryIndex < 0) {
        // The mod was not found.
        // TODO : Handle the case where the mod is within the list of mods
        // enabled in the profile load order, but its files do not exist
        // anymore within the mods directory.
      } else {
        // The mod was found.

        // Mark it as enabled when we load the profile.
        modsEnabled[entryIndex] = true;

        // Change its load order to match the order of the loaded profile data.
        modSetLoadOrder(entryIndex, modIndex);
        // NOTE : We do the quick and dirty thing. Just swap this object with
        // the one that was at its original index.
        // modsOrder[entryIndex] = modIndex;
        // modsOrder[modIndex] = entryIndex;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    initMenuProfileGeneric();

    if(widget.isNew) {
      initMenuProfileCreate();
    } else {
      initMenuProfileEdit();
    }
  }

  // endregion

  // region Main Widget

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

  // endregion

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
            EntryData entryData = EntryData(
              name: pathName(childDir.path),
              path: childDir.path,
            );
            foundInstalls.add(entryData);
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

  Widget getInstallEntry(EntryData entryData) {
    return InstallEntryWidget(
      text: entryData.name,
      path: entryData.path,
      selected: selectedInstall == entryData.name,
      onSelected: (){
        selectInstall(entryData.name);
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

  // Internal implementation to set load order.
  // Moves elements directly in memory.
  void modSetLoadOrderInternal(int originalIndex, int newIndex) {
    // Clamp the index so it does not go out of bounds
    const minIndex = 0;
    final maxIndex = modsName.length - 1;
    newIndex = clampIntValue(newIndex, minIndex, maxIndex);

    // Cache the values of the original entry
    var modName = modsName[originalIndex];
    var modEnabled = modsEnabled[originalIndex];

    // Remove the original entry
    modsName.removeAt(originalIndex);
    modsEnabled.removeAt(originalIndex);

    // Insert the entry into its new index
    modsName.insert(newIndex, modName);
    modsEnabled.insert(newIndex, modEnabled);
  }

  // Internal implementation to set load order.
  // Changes the load order indices.
  // Does not respect the original directory ordering, so it could be considered
  // to be a bit worse from the UX POV.
  // NOTE : We could do the same thing as on the other function but on the
  // order var rather than a swap if we cared about ordering that much.
  void modSetLoadOrderInternal2(int originalIndex, int newIndex) {
    // Literally just performs a simple swap.
    /*
    final int original = modsOrder[originalIndex];
    final int target = modsOrder[newIndex];
    modsOrder[originalIndex] = target;
    modsOrder[newIndex] = original;
    */
  }

  // Public function to set the load order of a mod
  void modSetLoadOrder(int originalIndex, int newIndex) {
    modSetLoadOrderInternal(originalIndex, newIndex);
  }

  void loadMods() {
    setState(() {
      modsName.clear();
      modsEnabled.clear();
      // modsOrder.clear();
    });
    Directory dir = Directory(ModManager.getPathToMods());
    var childDirs = dir.listSync().whereType<Directory>().toList();

    final int numMods = childDirs.length;

    setState(() {
      for (int i = 0; i < numMods; ++i) {
        modsName.add(pathName(childDirs[i].path));
        modsEnabled.add(false);
        // modsOrder.add(i);
      }
    });
  }

  Widget getMods(BuildContext context) {
    return MagickaPupScroller( // TODO : Change to use the ScrollerBuilder for performance in the future
      controller: controllerScrollMods,
      children: getModEntries(context),
    );
  }

  List<Widget> getModEntries(BuildContext context) {
    List<Widget> ans = [];
    for(int i = 0; i < modsName.length; ++i) {
      ans.add(getModEntry(context, i));
    }
    return ans;
  }

  Widget getModEntry(BuildContext context, int index) {
    return ModEntryWidget(
      text: modsName[index],
      path: pathJoin(ModManager.getPathToMods(), modsName[index]),
      selected: modsEnabled[index],
      onSelected: (){
        selectMod(index);
      },
      loadOrder: 0, // TODO : Get rid of this shit property please!!! or rework it or whatever...
      setLoadOrder: (){
        setLoadOrder(context, index);
      },
    );
  }

  void setLoadOrder(BuildContext context, int index) {
    showPopUpGeneric(
      context: context, title: "Set Load Order",
      description: "Do you want to change it bro?",
      body: MagickaPupTextField(
        controller: controllerPopUp,
        numeric: true,
      ),
      actions: [
        PopUpAction(
          text: "Ok",
          action: () {
            setState(() {

              // If no text was issued, don't move the entry and bail out.
              if(controllerPopUp.text.trim().isEmpty){
                return;
              }

              // Move the entry to the target location.
              final int target = int.parse(controllerPopUp.text);
              modSetLoadOrder(index, target);
            });
          }
        ),
      ],
    );
  }

  // Logic to enable / disable a mod
  void selectMod(int index) {
    setState(() {
      modsEnabled[index] = !modsEnabled[index];
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
    // TODO : Modify logic to work with async so that we can await the file generation to finish.

    // Variables to store the success status
    bool successfullyAppliedChanges = false;
    bool successfullyGeneratedFiles = false;

    // Generate the profile json file data
    if(widget.isNew) {
      // Create new profile
      successfullyAppliedChanges = createProfile(context);
    } else {
      // Edit the currently selected profile
      successfullyAppliedChanges = editProfile();
    }

    // Invoke mcow-mm and generate the game files for the profile
    successfullyGeneratedFiles = generateInstallFiles();

    // Check if the process was successful or not
    if(successfullyAppliedChanges && successfullyGeneratedFiles) {
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

  bool generateInstallFiles() {
    return true;
  }

  GameProfileData getProfileData() {
    GameProfileData profileData = GameProfileData();
    profileData.name = controllerProfileName.text;
    profileData.install = selectedInstall;
    profileData.mods = getEnabledMods();
    return profileData;
  }

  List<String> getEnabledMods() {
    List<String> ans = [];
    for(int i = 0; i < modsName.length; ++i) {
      if(modsEnabled[i]) {
        ans.add(modsName[i]);
      }
    }
    return ans;
  }

  // endregion
}
