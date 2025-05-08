import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mpup_manager.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container_simple.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpuplegacy_named_container.dart';

import 'package:file_picker/file_picker.dart';

void pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ["pdf", "txt", "json"],
  );
  if(result != null) {
    int idx = 0;
    for(var file in result.files) {
      print("File [$idx] = \"${file.name}\" (${file.path})");
      ++idx;
    }
  } else {
    print("File Pick Operation Cancelled. No file was selected.");
  }
}

// TODO : Make Function processFile not nullable.
void pickFiles(List<String> allowedExtensions, Function? processFile) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
  );

  if(result != null) {
    for(var file in result.files) {
      // processFile(file); // TODO : Implement
    }
  }
}

void pickDirectory() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if(selectedDirectory != null) {
    print("directory that was selected is $selectedDirectory");
  }
}

void pickFilesDecompile() async {
  pickFiles(["xnb"], null);
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return getMenuWidget();
  }

  Widget getMenuWidgetOld1() {
    return Scaffold(
        body: Container(
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded (
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        color: Colors.red,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        color: Colors.blue,
                                        child: const Text("Hello World!"),
                                      )
                                  )
                              ),
                              Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        color: Colors.blue,
                                        child: const Text("Hello World!"),
                                      )
                                  )
                              )
                            ]
                        ),
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Goodbye World!"),
                ),
                Row (
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () async {
                                  String process = "C:\\Users\\rodri\\Documents\\MagickaPUP\\MagickaPUP\\MagickaPUP\\bin\\Debug\\MagickaPUP.exe";
                                  List<String> arguments = [
                                    "-u",
                                    "C:\\cosas\\barrel_petrol.xnb",
                                    "C:\\cosas\\barrel_petrol.xnb.json2"
                                  ];

                                  var result = await Process.run(process, arguments);
                                  print(result.stdout);
                                },
                                child: const Text("Hello!"),
                              )
                          )
                      )
                    ]
                )
              ],
            )
        )
    );
  }

  Widget getMenuWidgetOld2() {
    return Scaffold(
      body: Column(
        children: [
          IntrinsicHeight (
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                          color: Colors.green,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Input Path")
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  color: Colors.blue
                                )
                              ),
                            ],
                          )
                      ),
                    )
                  ),
                  Container(
                      color: Colors.red,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            color: Colors.green,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text("Output Path")
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Container(
                                        color: Colors.blue
                                    )
                                ),
                              ],
                            )
                        ),
                      )
                  ),
                ],
              )
            )
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      color: Colors.red,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("Input Path")
                          )
                        ],
                      )
                  )
              )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: Text("fsaf")
                    )
                  ],
                ),
              )
            )
          ),
          Expanded(
            child: MagickaPupContainer(
              level: 2,
              //text: "HELLO",
              color: ThemeManager.getCurrentThemeData().colors.type.int,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: pickFile,
                    child: Text("Button")
                  )
                ],
              ),
            ),
          )
        ]
      )
    );
  }

  Widget getMenuWidget() {
    return Scaffold(
      body: MagickaPupBackground(
        child: Column(
          children: [
            Expanded(
              child: MagickaPupContainer(
                text: "Select Files",
                level: 1,
                child: Row(
                  children: [
                    MagickaPupText(
                      text: "Pick Files",
                    ),
                    MagickaPupButton(
                      text: "Explore",
                      onPressed: pickDirectory,
                    ),
                    ElevatedButton(
                      onPressed: pickFile,
                      child: Text("Pick dir"),
                    ),
                    Column(
                      children: [
                        MagickaPupContainer()
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Selected Files",
                level: 1,
                child: Row(),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Processed Files",
                child: Row(),
                level: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
