import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';
import 'package:mpupgui/widgets/mpuplegacy_button.dart';
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

  TextEditingController inputDirController = TextEditingController();
  TextEditingController outputDirController = TextEditingController();

  Future<void> pickDir(TextEditingController controller) async {
    String? directory = await getDirectoryPath();
    if(directory != null) {
      setState(() {
        controller.text = directory;
      });
    }
  }

  void pickInputDir() async {
    await pickDir(inputDirController);
  }

  void pickOutputDir() async {
    await pickDir(outputDirController);
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidgetOld(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: MagickaPupContainer(
                level: 1,
                text: "Paths",
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: MagickaPupContainer(
                        level: 2,
                        child: Column(
                          children: [
                            getPathWidgets("Input  Path", inputDirController, pickInputDir),
                            getPathWidgets("Output Path", outputDirController, pickOutputDir),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: MagickaPupContainer(
                        level: 2,
                        child: MagickaPupLegacyButton(
                          text: "Compile",
                          onPressed: onProcessFilesPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Expanded(
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
            ),*/
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Expanded(
                    child: MagickaPupContainer(
                      text: "Selected",
                      level: 1,
                    ),
                  ),
                  Expanded(
                    child: MagickaPupContainer(
                      text: "Finished",
                      level: 1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget getPathWidgets(String text, TextEditingController controller, Function processFileFunction) {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: IntrinsicWidth(
              child: MagickaPupText(
                text: text,
                fontSize: 14,
                isBold: true,
                isMonospace: true,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: MagickaPupTextField(
              controller: controller,
            ),
          ),
          MagickaPupButton(
            width: 60,
            height: 10,
            onPressed: () async {
              processFileFunction();
            },
            child: MagickaPupText(
              text: "...",
            )
          ),
        ],
      ),
    );
  }

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                height: 140,
                text: "Actions",
                level: 2,
                child: Row(
                  children: [
                    getActionButton("Explore Files", pickInputDir),
                    getActionButton("Explore Directory", pickInputDir),
                    getActionButton("Explore Directory", pickOutputDir),
                    getActionButton("Compile", pickInputDir),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Files",
                level: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getActionButton(String actionText, VoidCallback function) {
    return Expanded(
        child: MagickaPupButton(
          height: 10,
          onPressed: function,
          child: MagickaPupText(
              text: actionText,
          ),
        ),
      );
  }
}
