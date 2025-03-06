import 'package:flutter/material.dart';

import '../data/theme_manager.dart';
import 'mpup_text.dart';

class MagickaPupFileProcessor extends StatelessWidget {

  const MagickaPupFileProcessor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeManager.getColorImage(0),
      child: Padding(
        padding : const EdgeInsets.all(15),
        child: Container(
          color: ThemeManager.getColorImage(1),
          child: const MagickaPupText(text : "Some test")
        )
      )
    );
  }
}

