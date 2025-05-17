import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenuProfileEntry extends StatefulWidget {
  const ModManagerMenuProfileEntry({super.key});

  @override
  State<ModManagerMenuProfileEntry> createState() => _ModManagerMenuProfileEntryState();
}

class _ModManagerMenuProfileEntryState extends State<ModManagerMenuProfileEntry> {
  @override
  Widget build(BuildContext context) {
    return MagickaPupBackground(
      child: MagickaPupContainer(
        level: 2,
        child: MagickaPupText(
          text: "hi",
        ),
      ),
    );
  }
}
