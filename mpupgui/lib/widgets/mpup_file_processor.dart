import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_named_container.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';

import '../data/theme_manager.dart';
import 'mpup_text.dart';

class MagickaPupFileProcessor extends StatefulWidget {

  final String processFileLocString;
  final String processFileCmdString;
  final String processFileExtString;

  const MagickaPupFileProcessor({
    super.key,
    required this.processFileLocString,
    required this.processFileCmdString,
    required this.processFileExtString,
  });

  @override
  State<MagickaPupFileProcessor> createState() => _MagickaPupFileProcessorState(
    processFileLocString: processFileLocString,
    processFileCmdString: processFileCmdString,
    processFileExtString: processFileExtString,
  );
}

class _MagickaPupFileProcessorState extends State<MagickaPupFileProcessor> {

  final String processFileLocString;
  final String processFileCmdString;
  final String processFileExtString; // Extension of the target output files. NOTE : In the future, this will no longer be required, as the CLI mpup will be the one to internally manage the selection of the correct output file name if no user defined or custom output file name is given to the program.

  String debugLogText = "";

  _MagickaPupFileProcessorState({
    required this.processFileLocString,
    required this.processFileCmdString,
    required this.processFileExtString,
  });

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: MagickaPupNamedContainer(
              text: "   ${LanguageManager.getString("loc_input_file_path")}:",
              colorIndex: 2,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MagickaPupTextField(
                          controller: controller,
                          onEdit: (){}, // NOTE : Not really required actually. Maybe should find a way to make this param optional in the widget?
                        )
                      ),
                    ],
                  ),
              ),
            )
        ),
        Expanded(
            child: MagickaPupNamedContainer(
                text: "   ${LanguageManager.getString("loc_console")}:",
                colorIndex: 2,
                child: Scrollbar(
                    controller: scrollController,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: MagickaPupText(
                              text: debugLogText,
                              isSelectable: true,
                              isMonospace: true,
                            )
                        )
                    )
                )
            )
        ),
        MagickaPupContainer(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: MagickaPupButton(
              text: LanguageManager.getString(processFileLocString),
              colorIndex: 2,
              onPressed: startProcess,
          )
        ),
      ],
    );
  }

  void setDebugLogText(String newValue) {
    setState(() {
      debugLogText = newValue;
    });
  }

  void addDebugLogText(String toAdd) {
    setState(() {
      debugLogText = debugLogText + toAdd;
    });
  }

  void scrollToTop() {
    setState((){
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void scrollToBottom() {
    setState((){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void startProcess() async {
    // Reset the debug log text back to an empty string and scroll to the top
    scrollToTop(); // NOTE : We do this first so as to prevent issues in certain platforms where we could get some px overflows if we don't scroll back first.
    setDebugLogText("");

    // Execute the backend mpup process
    // NOTE : No need to add quotations with \" to the inputFile and outputFile strings.
    // That is only required when passing arguments to a program through a shell.
    // In this case, we're starting the process directly, so we pass an array of args,
    // which means that the string for each arg is the arg itself and there is no risk of
    // whitespace in the args (for example: paths with spaces) being interpreted as different args.
    String executable = MagickaPupManager.currentMagickaPupPath;
    String inputFile = controller.text;
    String outputFile = "${controller.text}.$processFileExtString";
    List<String> arguments = controller.text.trim().length > 0 ? [
      processFileCmdString,
      inputFile,
      outputFile,
    ] : [
      processFileCmdString // Only one argument so that we get automatically the help message for -u and -p
    ];
    Process process = await Process.start(
      executable,
      arguments,
      // NOTE : Maybe we need to add the "mode:" process start mode param here in the future for wider platform support?
    );

    // Capture stdout and stderr
    process.stdout.transform(systemEncoding.decoder).listen((data){
      addDebugLogText(data);
      scrollToBottom(); // Scroll to bottom when a message is received
    });
    process.stderr.transform(systemEncoding.decoder).listen((data){
      addDebugLogText(data);
      scrollToBottom(); // Scroll to bottom when a message is received
    });

    // Wait for the process to finish and exit.
    process.exitCode.then((exitCode){
      // print("Process exited with code : $exitCode");
      scrollToBottom(); // Scroll to bottom when the program finishes running
    });
  }
}
