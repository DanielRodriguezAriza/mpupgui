import 'dart:io';

import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      String process = "C:\\MagickaPUP.exe";
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
}
