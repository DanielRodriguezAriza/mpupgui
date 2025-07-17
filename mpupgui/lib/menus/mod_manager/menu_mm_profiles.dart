import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/game_profile_data.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm_generic_list_display.dart';
import 'package:mpupgui/menus/mod_manager/profile/menu_mm_profile_entry.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/utility/popup_util.dart';
import 'package:mpupgui/utility/process_util.dart';
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
            createProfile(context);
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
        var data = GameProfileData();
        return data.tryReadFromFile(file.path);
      }
    }
    return false;
  }

  String directoryGetter() {
    return ModManager.getPathToProfiles();
  }

  Widget getEntryWidget(String name, String path) {
    GameProfileData profileData = GameProfileData();
    profileData.tryReadFromFile(pathJoin(path, "profile.json"));
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
                    level: isProfileInstalled(path) ? 4 : 5,
                    useAutoPadding: false,
                    onPressed: () async {
                      await _profileEntryTryExecute(profileData, name, path);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_play.png"),
                      ),
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
                      await _profileEntryTryInstall(profileData, name, path);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_install.png"),
                      ),
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
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_gear.png"),
                      ),
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
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_folder.png"),
                      ),
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
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_x.png"),
                      ),
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

  // TODO : In the future, make it so that profile install is performed automatically as a sort of "refresh" mechanic
  // Maybe on boot, all profiles try to "reinstall" / "refresh" to check if they are properly installed and up to date
  // (as a sort of steam verifying files / checking for updates).
  // Then, when a profile is edited or created, on exit, do the same thing.
  // The install should be like a loading bar or spinner on each profile individually, that way we can allow multiple
  // profiles to be installed at once, and players can play or do whatever else while other profile installs, etc...

  // This used to be called "profileEntryTryLaunch"
  // Note that this function is pretty much unused as of now...
  // This is because we now separate the install and launch process into 2 different functions.
  Future<void> profileEntryTryInstallAndExecute(GameProfileData profileData, String dirName, String path) async {
    bool installSuccess = await _profileEntryTryInstall(profileData, dirName, path);
    if(installSuccess) {
      bool executeSuccess = await _profileEntryTryExecute(profileData, dirName, path);
    }
    // NOTE : This code can be changed to use early returns on if(!whateverSuccess) {return;}
    // in the future in the event that we would want to implement multiple async steps.
    // That way, the code would not have a gazillion indentations.
    // For now tho, this is ok, so we'll leave it as it is.
  }

  Future<bool> _profileEntryTryInstall(GameProfileData profileData, String dirName, String path) async {
    try {
      showPopUpGeneric(
        context: context,
        title: "Preparing install...",
        description: "The install is being prepared.",
        canClose: false,
        canDismiss: false,
      );

      final String pi = pathFix(ModManager.getPathToInstalls());
      final String pm = pathFix(ModManager.getPathToMods());
      final String pp = pathFix(ModManager.getPathToProfiles());

      final bool isSameDrive = isSameDriveManySync([pi, pm, pp]);
      final bool needsAdmin = !isSameDrive && Platform.isWindows;
      final String fhm = isSameDrive ? "hardlink" : "symlink";

      String processName = pathFix(ModManager.getPathToMagickCowModManager());
      List<String> args = [
        "-pi", pi,
        "-pm", pm,
        "-pp", pp,
        "-fhm", fhm,
        "-a", dirName,
      ];

      // NOTE : Some debug logging stuff, remove this in the future.
      print("Running mcow-mm with these paths:");
      print("    - mcow-mm : $processName");
      print("    - pi : $pi");
      print("    - pm : $pm");
      print("    - pp : $pp");

      var process = await processStart(
        processName,
        args,
        needsAdmin,
      );

      process.stderr.drain();
      process.stdout.drain();

      // process.stderr.transform(systemEncoding.decoder).forEach((x){msgError += x;});
      // process.stdout.transform(utf8.decoder).forEach(print);

      // This fucking shit refuses to capture the entire stderr for some reason under windows. Ofc, how the fuck now, it had to fail on windows, what a fucking surprise! best OS ever!!!
      // final String msgError = await process.stderr.transform(systemEncoding.decoder).join();

      // This on the other hand does actually fucking work, which means that I'll have to find a workaround... maybe force the underlying process to pipe error messages to stdout instead of stderr, but that's dirty as fuck, what the fuck windows?
      // final msg = await process.stdout.transform(systemEncoding.decoder).join();
      // print(msg);

      var exitCode = await process.exitCode;

      if(mounted) {
        Navigator.pop(context, "Ok");
      }

      if(exitCode != 0) {
        // There was an error installing the profile
        throw Exception("Failed to install the profile" /*msgError*/);
        // TODO : Modify this so that the exception msg str is used as a
        // loc string or something like that, maybe?
      } else {
        if(mounted) {
          showPopUpError(
            context: context,
            title: "Success",
            description: "Profile successfully installed!",
          );
        }
      }

      return true; // Report Success
    } catch(e) {
      // Generic error handling when installing fails
      if(mounted) {
        showPopUpError(
          context: context,
          title: "Error",
          description: "Could not install the profile!",
        );
      }
      print(e);
      return false; // Report Failure
    }
  }

  Future<bool> _profileEntryTryExecute(GameProfileData profileData, String dirName, String path) async {
    try {
      String processName = pathJoinMany([path, "game", "Magicka.exe"]);
      List<String> args = [];
      String workingDirectory = pathJoin(path, "game");
      var process = await Process.start(processName, args, workingDirectory: workingDirectory); // Ensure that the working directory is set to the game folder so that even installs made through symlinks can work.
      process.stdout.drain();
      process.stderr.drain();
      return true; // Report success
    } catch(e) {
      if(mounted) {
        showPopUpError(
          context: context,
          title: "An Error has occurred!",
          description: "Magicka has failed to launch!",
        );
      }
      return false; // Report failure
    }
  }

  void createProfile(BuildContext context) {
    selectedProfilePath = "";
    selectedProfileIsNew = true;
    setState(() {
      menuIndex = 1;
    });
  }

  void editProfile(BuildContext context, String path) {
    selectedProfilePath = path;
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

  bool isProfileInstalled(String path) {
    String exePath = pathJoinMany([path, "game", "Magicka.exe"]);
    return pathExists(exePath);
  }
}
