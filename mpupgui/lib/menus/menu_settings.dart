import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/settings_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpuplegacy_button.dart';
import 'package:mpupgui/widgets/mpuplegacy_container.dart';
import 'package:mpupgui/widgets/mpuplegacy_named_container.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';


// TODO : Either make this a stateful widget or reload the "scene" / "page" / "menu" so that changes to visual settings are applied to all of the UI, for example theme change.

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {

  final TextEditingController textControllerMagickaPup = TextEditingController();
  final TextEditingController textControllerInstalls = TextEditingController();
  final TextEditingController textControllerMods = TextEditingController();
  final TextEditingController textControllerProfiles = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadSettings();
    });
  }

  void loadSettings() {
    // NOTE : We load the settings again every time we enter the scene.
    // This is done just in case users have modified their settings manually by editing the settings json file.
    SettingsManager.loadSettings();
    textControllerMagickaPup.text = MagickaPupManager.getMagickaPupPath();
    textControllerInstalls.text = ModManager.getPathToInstalls();
    textControllerMods.text = ModManager.getPathToMods();
    textControllerProfiles.text = ModManager.getPathToProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidgetOld(BuildContext context) {
    return MagickaPupScaffold(
        child: MagickaPupLegacyContainer(
          paddingParent: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: MagickaPupLegacyNamedContainer(
                      text: "   App Themes",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: MagickaPupLegacyButton(
                                text: LanguageManager.getString("loc_theme_light"),
                                colorIndex: 3,
                                onPressed: (){
                                  setTheme(AppTheme.light);
                                },
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: MagickaPupLegacyButton(
                                  text: LanguageManager.getString("loc_theme_dark"),
                                  colorIndex: 3,
                                  onPressed: (){
                                    setTheme(AppTheme.dark);
                                  }
                              )
                          )
                        ],
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: MagickaPupLegacyNamedContainer(
                      text: "   Magicka PUP CLI Executable Path",
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MagickaPupTextField(
                            controller: textControllerMagickaPup,
                            onEdit: (){
                              setPathMagickaPup(textControllerMagickaPup.text);
                            },
                          )
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height:120,
                  child:MagickaPupLegacyNamedContainer(
                      text: "    Path To Installs",
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MagickaPupTextField(
                              controller: textControllerInstalls,
                              onEdit: (){
                                setPathInstalls(textControllerInstalls.text);
                              }
                          )
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height:120,
                  child:MagickaPupLegacyNamedContainer(
                      text: "    Path To Mods",
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MagickaPupTextField(
                              controller: textControllerMods,
                              onEdit: (){
                                setPathMods(textControllerMods.text);
                              }
                          )
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height:120,
                  child:MagickaPupLegacyNamedContainer(
                      text: "    Path To Profiles",
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MagickaPupTextField(
                              controller: textControllerProfiles,
                              onEdit: (){
                                setPathProfiles(textControllerProfiles.text);
                              }
                          )
                      )
                  )
              )
            ],
          ),
        )
    );
  }

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        level: 0,
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                text: "Theme",
                level: 2,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: MagickaPupButton(
                        onPressed: (){
                          setTheme(AppTheme.dark);
                        },
                        child: MagickaPupText(
                          text: "Dark Theme",
                          isBold: true,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: MagickaPupButton(
                        onPressed: (){
                          setTheme(AppTheme.light);
                        },
                        child: MagickaPupText(
                          text: "Light Theme",
                          isBold: true,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Paths",
                level: 2,
                child: getPathsWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPathsWidgets() {
    return Column(
      children: [
        getPathWidget("Magicka PUP", setPathMagickaPup, textControllerMagickaPup),
        getPathWidget("Installs", setPathInstalls, textControllerInstalls),
        getPathWidget("Mods", setPathMods, textControllerMods),
        getPathWidget("Profiles", setPathProfiles, textControllerProfiles),
      ]
    );
  }

  Widget getPathWidget(String text, Function action, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: MagickaPupContainer(
        height: 40,
        level: 1,
        child: Row(
            children: [
              Expanded(
                flex: 1,
                child: MagickaPupText(
                  text: text,
                ),
              ),
              Expanded(
                flex: 9,
                child: MagickaPupTextField(
                  maxHeight: 30,
                  controller: controller,
                  onEdit: (){
                    action(controller.text);
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }

  void setTheme(AppTheme theme) {
    setState((){
      ThemeManager.setTheme(theme);
      SettingsManager.saveSettings();
    });
  }

  void setPathMagickaPup(String path) {
    setState(() {
      MagickaPupManager.setMagickaPupPath(path);
      SettingsManager.saveSettings();
    });
  }

  void setPathInstalls(String path) {
    setState(() {
      ModManager.setPathToInstalls(path);
      SettingsManager.saveSettings();
    });
  }

  void setPathMods(String path) {
    setState(() {
      ModManager.setPathToMods(path);
      SettingsManager.saveSettings();
    });
  }

  void setPathProfiles(String path) {
    setState(() {
      ModManager.setPathToProfiles(path);
      SettingsManager.saveSettings();
    });
  }
}

/*
class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MagickaPupContainer(
        paddingParent: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MagickaPupButton(text: LanguageManager.getString("loc_theme_light"), onPressed: (){ThemeManager.setTheme(AppTheme.light);}, colorIndex: 2),
            MagickaPupButton(text: LanguageManager.getString("loc_theme_dark"), onPressed: (){ThemeManager.setTheme(AppTheme.dark);}, colorIndex: 2),
          ],
        ),
    );
  }
}
*/

