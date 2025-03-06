import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/menu_scaffold.dart';

import '../data/menu_manager.dart';
import '../data/theme_manager.dart';
import '../widgets/mpup_button.dart';

// TODO : Get rid of this maybe? Or make this a "what's new" kind of screen.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(15),
       child: Row(
           children:[
             MagickaPupButton(sizeX: 150, text: "Decompiler", onPressed: (){}),
             MagickaPupButton(sizeX: 150, text: "Compiler", onPressed: (){}),
             MagickaPupButton(sizeX: 150, text: "Settings", onPressed: (){}),
           ]
       )
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  color: ThemeManager.getColorImage(1),
                  height: 300,
                  width: constraints.maxWidth
              );
            }
        )
      )
    ],);
  }
}

/*
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("MagickaPUP GUI"),
            actions: [
              IconButton(
                  onPressed: () {
                    MenuManager.setMenu(1);
                  },
                  icon: Text("Decompile")
              ),
              IconButton(
                  onPressed: () {  },
                  icon: Text("Compile")
              ),
              IconButton(
                  onPressed: () {  },
                  icon: Text("Run All")
              )
            ]
        ),
      body: Container(
        child: Row(
          children: [
            MenuManager.getMenu(),
            const Text("test"),
            MagickaPupButton(
              text: 'Decompiler',
              onPressed: (){},
              sizeX: 150
            ),
            MagickaPupButton(
              text: 'Compiler',
              onPressed: (){},
              sizeX: 150
            ),
            MagickaPupButton(
              text: 'Settings',
              onPressed: (){},
              sizeX: 150
            )
          ],
        )
      ),
    );
  }
}
*/
