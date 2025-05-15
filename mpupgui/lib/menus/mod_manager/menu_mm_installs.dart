import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenuInstalls extends StatelessWidget {
  const ModManagerMenuInstalls({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Expanded(
                      child: MagickaPupButton(
                        onPressed: (){},
                        child: MagickaPupText(
                          text: "Add new Install",
                        ),
                      ),
                    ),
                    Expanded(
                      child: MagickaPupButton(
                        onPressed: (){},
                        child: MagickaPupText(
                          text: "Open Installs Directory",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Installs",
                level: 2,
                child: Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
