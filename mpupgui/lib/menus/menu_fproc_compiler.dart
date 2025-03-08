import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_file_processor.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';

class CompilerMenu extends StatelessWidget {
  const CompilerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MagickaPupScaffold(
      child: MagickaPupFileProcessor()
    );
  }
}

