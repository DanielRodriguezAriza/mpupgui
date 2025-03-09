import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_container.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: MagickaPupContainer(
              colorIndex: 2,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MagickaPupText(text: "${LanguageManager.getString("loc_input_file_path")}:"),
                      Expanded(
                        child: MagickaPupTextField(
                          controller: controller,
                          onEdit: (){}, // TODO : Implement
                        )
                      ),
                    ],
                  ),
              ),
            )
        ),
        Expanded(
            child: MagickaPupContainer(
              colorIndex: 2,
              child: MagickaPupText(text: debugLogText),
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

  void startProcess() async {
    // Reset the debug log text back to an empty string
    setDebugLogText("");

    // Execute the backend mpup process
    String executable = MagickaPupManager.currentMagickaPupPath;
    List<String> arguments = [
      processFileCmdString,
      controller.text,
      "${controller.text}.${processFileExtString}",
    ];
    Process process = await Process.start(
      executable,
      arguments,
    );

    // Capture stdout and stderr
    process.stdout.transform(utf8.decoder).listen((data){
      addDebugLogText(data);
      print("data : ${data}");
    });
    process.stderr.transform(utf8.decoder).listen((data){
      addDebugLogText(data);
      print("data : ${data}");
    });

    process.exitCode.then((exitCode){
      print("Process exited with code : $exitCode");
    });
  }
}

/*
class MagickaPupFileProcessor extends StatelessWidget {

  const MagickaPupFileProcessor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: MagickaPupContainer(
              colorIndex: 2,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: MagickaPupText(text: "Input file path")
              ),
            )
        ),
        Expanded(
            child: MagickaPupContainer(
              colorIndex: 2,
              child: MagickaPupText(text: "0"),
            )
        ),
      ],
    );
  }
}
*/
