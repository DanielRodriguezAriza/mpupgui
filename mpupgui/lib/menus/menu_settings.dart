import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/settings_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
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

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      SettingsManager.loadSettings(); // Load settings again. This is done just in case users have modified their settings manually by editing the settings json file.
      controller.text = MagickaPupManager.currentMagickaPupPath;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: controller,
                      onEdit: (){
                        setPath(controller.text);
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
                    controller: controller,
                    onEdit: (){}
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
                            controller: controller,
                            onEdit: (){}
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
                            controller: controller,
                            onEdit: (){}
                        )
                    )
                )
            )
          ],
        ),
      )
    );
  }

  void setTheme(AppTheme theme) {
    setState((){
      ThemeManager.setTheme(theme);
      SettingsManager.saveSettings();
    });
  }

  void setPath(String path) {
    setState((){
      MagickaPupManager.setMagickaPupPath(path);
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

