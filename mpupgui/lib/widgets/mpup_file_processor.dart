import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_container.dart';

import '../data/theme_manager.dart';
import 'mpup_text.dart';

class MagickaPupFileProcessor extends StatefulWidget {
  const MagickaPupFileProcessor({super.key});

  @override
  State<MagickaPupFileProcessor> createState() => _MagickaPupFileProcessorState();
}

class _MagickaPupFileProcessorState extends State<MagickaPupFileProcessor> {

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
                      MagickaPupText(text: "Input file path: "),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start
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
              child: MagickaPupText(text: "0"),
            )
        ),
      ],
    );
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
