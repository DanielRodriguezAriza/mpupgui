import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_file_processor_generic.dart';

class CompilerMenu extends StatelessWidget {
  const CompilerMenu({super.key});

  @override
  Widget build(BuildContext context) {

    // NOTE : The compiler can try to compile any type of asset.
    // We could leave it at that for now, but in the future maybe it would make
    // sense to limit it to formats that mpup actually understands? but with
    // this, it becomes far more trivial to maintain these 2 programs as
    // separate, since updates to compiler support should not affect
    // functionality of the gui. We'll see what I do in the end idk.
    // Anyway, for now, I'm adding json and png and then we'll add more
    // stuff or we'll get rid of this shit idk...

    return const MagickaPupFileProcessorMenuGeneric(
      extensions: ["json", "png"],
      executionArgument: "-p",
      locString: "loc_compile",
    );
  }
}

