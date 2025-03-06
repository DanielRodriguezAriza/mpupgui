import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

// TODO : Either make this a stateful widget or reload the "scene" / "page" / "menu" so that changes to visual settings are applied to all of the UI, for example theme change.

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

