import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';

class DecompilerMenu extends StatelessWidget {
  const DecompilerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MagickaPupFileProcessorMenuGeneric(
      extensions: ["xnb"],
      executionArgument: "-u",
      locString: "loc_decompile",
    );
  }
}

