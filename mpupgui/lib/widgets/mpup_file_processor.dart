import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_container.dart';

import '../data/theme_manager.dart';
import 'mpup_text.dart';

class MagickaPupFileProcessor extends StatelessWidget {

  const MagickaPupFileProcessor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: ThemeManager.getColorImage(2),
              child: MagickaPupText(text: "0"),
            )
          )
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: MagickaPupContainer(
                  width: MediaQuery.of(context).size.width,
                  colorIndex: 2,
                  child: MagickaPupText(text: "0"),
                )
            )
        ),
      ],
    );
  }
}

