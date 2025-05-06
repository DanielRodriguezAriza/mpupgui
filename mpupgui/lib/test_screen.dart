import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/mpup_container_simple.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpuplegacy_named_container.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return getMenuWidget();
  }

  Widget getWidgetOld() {
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

  Widget getMenuWidget() {
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
          const Expanded(
            child: MagickaPupContainer(
              level: 2,
              //text: "HELLO",
              color: Colors.red,
              child: Row(
                children: [],
              ),
            ),
          )
        ]
      )
    );
  }

}
