import 'package:flutter/material.dart';
import 'package:mpupgui/data/language_manager.dart';
import 'package:mpupgui/widgets/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';

import '../data/theme_manager.dart';
import 'mpup_text.dart';

class MagickaPupFileProcessor extends StatefulWidget {

  final String processFileLocString;
  final String processFileCmdString;

  const MagickaPupFileProcessor({
    super.key,
    required this.processFileLocString,
    required this.processFileCmdString,
  });

  @override
  State<MagickaPupFileProcessor> createState() => _MagickaPupFileProcessorState(
    processFileLocString: processFileLocString,
    processFileCmdString: processFileCmdString
  );
}

class _MagickaPupFileProcessorState extends State<MagickaPupFileProcessor> {

  final String processFileLocString;
  final String processFileCmdString;

  _MagickaPupFileProcessorState({
    required this.processFileLocString,
    required this.processFileCmdString
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
                          controller: controller
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
        MagickaPupContainer(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: MagickaPupButton(
              text: LanguageManager.getString(processFileLocString),
              colorIndex: 2,
              onPressed: (){}
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
