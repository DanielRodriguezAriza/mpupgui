import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

// Generic class for file processors.
// Encapsulates logic and layout that can be used by both the compiler and the
// decompiler menus.
class MagickaPupFileProcessorMenuGeneric extends StatefulWidget {
  const MagickaPupFileProcessorMenuGeneric({
    super.key
  });

  @override
  State<MagickaPupFileProcessorMenuGeneric> createState() => _MagickaPupFileProcessorMenuGenericState();
}

class _MagickaPupFileProcessorMenuGenericState extends State<MagickaPupFileProcessorMenuGeneric> {
  void onProcessFilesPressed() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: MagickaPupContainer(
                level: 1,
                text: "Compiler - Paths",
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: MagickaPupContainer(
                        level: 2,
                      ),
                    ),
                    Expanded(
                      child: MagickaPupContainer(
                        level: 2,
                        child: MagickaPupButton(
                          text: "Compile",
                          onPressed: onProcessFilesPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: MagickaPupContainer(
                level: 1,
                text: "Compiler",
                child: Column(
                  children: [
                    Expanded(
                      child: MagickaPupContainer(
                        text: "Compiling (in-progress)",
                        level: 2,
                      ),
                    ),
                    Expanded(
                      child: MagickaPupContainer(
                        text: "Compiled (finished)",
                        level: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
