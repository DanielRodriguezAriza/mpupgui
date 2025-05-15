import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenuInstalls extends StatefulWidget {
  const ModManagerMenuInstalls({super.key});

  @override
  State<ModManagerMenuInstalls> createState() => _ModManagerMenuInstallsState();
}

class _ModManagerMenuInstallsState extends State<ModManagerMenuInstalls> {

  ScrollController controller = ScrollController();

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
                child: MagickaPupScroller(
                  controller: controller,
                  children: [
                    Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),Container(
                      color: Colors.red,
                      height: 20,
                    ),Container(
                      color: Colors.green,
                      height: 20,
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
