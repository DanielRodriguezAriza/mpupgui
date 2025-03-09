import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_file_processor.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';

class DecompilerMenu extends StatelessWidget {
  const DecompilerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MagickaPupScaffold(
        child: MagickaPupFileProcessor(
          processFileLocString: "loc_decompile",
          processFileCmdString: "-u",
        )
    );
  }
}

