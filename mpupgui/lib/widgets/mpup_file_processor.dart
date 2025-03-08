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
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: MagickaPupContainer(
              colorIndex: 2,
              child: MagickaPupText(text: "0"),
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

