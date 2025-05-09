import 'package:flutter/material.dart';
import 'package:mpupgui/utility/file_handling.dart';
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

  final List<String>? extensions;

  const MagickaPupFileProcessorMenuGeneric({
    super.key,
    this.extensions,
  });

  @override
  State<MagickaPupFileProcessorMenuGeneric> createState() => _MagickaPupFileProcessorMenuGenericState();
}

class _MagickaPupFileProcessorMenuGenericState extends State<MagickaPupFileProcessorMenuGeneric> {

  List<String> inputPaths = [];
  String outputPath = "";

  List<String> compiledPaths = [];

  void onProcessFilesPressed() async {
    // TODO : Implement
  }

  void pickInputDir() async {
    String? dir = await pickDir();
    if(dir != null) {
      setState(() {
        inputPaths.add(dir);
      });
    }
  }

  void pickOutputDir() async {
    String? dir = await pickDir();
    if(dir != null) {
      setState(() {
        outputPath = dir;
      });
    }
  }

  void pickInputFiles() async {
    List<String>? files = await pickFiles(true, widget.extensions);
    if(files != null) {
      setState(() {
        // I'm sure there's something like  an .extend() or .append() call to
        // join the list directly, but I could not find it on the docs :(
        for(var file in files) {
          inputPaths.add(file);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  // OLD DEPRECATED CODE. TODO : Remove!
  /*
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
  */

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                height: 60,
                text: "Actions",
                level: 2,
                child: Row(
                  children: [
                    getActionButton("Explore Files", pickInputFiles),
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
