import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenu extends StatelessWidget {
  const ModManagerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MagickaPupScaffold(child: MagickaPupText(text: "Mod Manager"));
  }
}
