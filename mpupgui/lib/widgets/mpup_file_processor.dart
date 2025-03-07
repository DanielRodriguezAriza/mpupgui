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
          child:Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: MagickaPupText(text: "0"),
          )
        ),
        Expanded(
        child:Container(
            color: Colors.red,
            child: MagickaPupText(text: "1")
        )),
      ],
    );
  }
}

