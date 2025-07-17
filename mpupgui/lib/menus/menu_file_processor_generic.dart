import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/utility/process_util.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupPathData {
  final String name;
  final String path;

  const MagickaPupPathData({
    required this.name,
    required this.path,
  });
}

enum MagickaPupProcessState {
  waiting,
  running,
  success,
  failure,
}

class MagickaPupProcessData {
  MagickaPupProcessState status;
  final String name;
  final String path;

  MagickaPupProcessData({
    required this.name,
    required this.path,
    this.status = MagickaPupProcessState.waiting,
  });
}

// Generic class for file processors.
// Encapsulates logic and layout that can be used by both the compiler and the
// decompiler menus.
class MagickaPupFileProcessorMenuGeneric extends StatefulWidget {

  final List<String>? extensions;
  final String executionArgument;
  final String locString;

  const MagickaPupFileProcessorMenuGeneric({
    super.key,
    this.extensions,
    this.executionArgument = "-u",
    this.locString = "loc_decompile",
  });

  @override
  State<MagickaPupFileProcessorMenuGeneric> createState() => _MagickaPupFileProcessorMenuGenericState();
}

class _MagickaPupFileProcessorMenuGenericState extends State<MagickaPupFileProcessorMenuGeneric> {

  List<MagickaPupPathData> inputPaths = [];
  List<MagickaPupProcessData> runningProcesses = [];

  TextEditingController outputPathController = TextEditingController();

  ScrollController scrollControllerSelected = ScrollController();
  ScrollController scrollControllerCompiled = ScrollController();

  void commitProcesses() {
    setState(() {
      for(var path in inputPaths) {
        var process = MagickaPupProcessData(
          name: path.name,
          path: path.path,
        );
        runningProcesses.add(process);
      }
      inputPaths.clear();
    });
  }

  void runProcesses() {
    for(var p in runningProcesses) {
      runProcess(p);
    }
  }

  void startRunningProcesses() {
    commitProcesses();
    runProcesses();
  }

  void runProcess(MagickaPupProcessData processData) async {

    String executable = pathFix(MagickaPupManager.getMagickaPupPath()); // Path separators fixed to prevent issues when executing from relative paths.

    String opStr = widget.executionArgument;
    String inputPath = processData.path;
    String outputPath = pathJoin(outputPathController.text, processData.name);
    List<String> arguments = [
      "-d", "0", // Debug logging disabled for increased runtime performance. And also because nobody is going to read all that shit.
      opStr, inputPath, outputPath,
    ];

    // NOTE : Set the state BEFORE actually starting the process.
    // We do this because if we did a setState() call after Process.start(),
    // we could potentially waste more time than it takes for awaiting the exit code of the program
    // which would cause the await exitCode to never be notified.
    setState(() {
      processData.status = MagickaPupProcessState.running;
    });

    var process = await processStart(executable, arguments);

    // Drain the pipes to prevent any issues.
    // If they fill up (specially stderr when printing a large stack trace), the subprocess will "freeze" and never notify
    // the await on process.exitCode...
    process.stdout.drain();
    process.stderr.drain();

    var status = await process.exitCode;
    setState(() {
      processData.status = status == 0 ? MagickaPupProcessState.success : MagickaPupProcessState.failure;
    });
  }

  void pickInputDir() async {
    String? dir = await pickDir();
    if(dir != null) {
      setState(() {
        var data = MagickaPupPathData(
          name: pathName(dir),
          path: dir,
        );
        inputPaths.add(data);
      });
    }
  }

  void pickOutputDir() async {
    String? dir = await pickDir();
    if(dir != null) {
      setState(() {
        outputPathController.text = dir;
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
          var data = MagickaPupPathData(
            name: pathName(file),
            path: file
          );
          inputPaths.add(data);
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
                    getActionButton("Select Files", pickInputFiles),
                    getActionButton("Select Directory", pickInputDir),
                    getActionButton("Set Output Directory", pickOutputDir),
                    getActionButton(LanguageManager.getString(widget.locString), startRunningProcesses),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Files",
                level: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: MagickaPupText(
                              text: "Output Path",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: MagickaPupTextField(
                              maxHeight: 25,
                              controller: outputPathController,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: MagickaPupContainer(
                        level: 0,
                        text: "Selected Paths",
                        child: Scrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: scrollControllerSelected,
                          child: ListView(
                            controller: scrollControllerSelected,
                            children: getSelectedPathsWidgets(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: MagickaPupContainer(
                        level: 0,
                        text: "Running Processes",
                        child: Scrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: scrollControllerCompiled,
                          child: ListView(
                            controller: scrollControllerCompiled,
                            children: getRunningProcessesWidgets(),
                          ),
                        ),
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

  List<Widget> getSelectedPathsWidgets() {
    List<Widget> ans = [];
    var themeData = ThemeManager.getCurrentThemeData();
    int index = 0;
    for(var pathData in inputPaths) {
      ans.add(getPathWidget(index, pathData, themeData));
      ++index;
    }
    return ans;
  }

  Widget getPathWidget(int index, MagickaPupPathData pathData, AppThemeData themeData) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            color: themeData.colors.image[index % 2 == 0 ? 1 : 2],
            height: 22,
          ),
          MagickaPupText(
            text: pathData.path,
            isSelectable: true,
          ),
        ],
      ),
    );
  }

  List<Widget> getRunningProcessesWidgets() {
    List<Widget> ans = [];
    var themeData = ThemeManager.getCurrentThemeData();
    int index = 0;
    for(var processData in runningProcesses) {
      ans.add(getRunningProcessWidget(index, processData, themeData));
      ++index;
    }
    return ans;
  }

  Widget getRunningProcessWidget(int index, MagickaPupProcessData processData, AppThemeData themeData) {
    return MagickaPupText(
      text: "STATUS: ${processData.status} | PATH: ${processData.path}",
    );
  }
}
