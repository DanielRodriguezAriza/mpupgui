import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/menu_scaffold.dart';

// TODO : Get rid of this maybe? Or make this a "what's new" kind of screen.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    
    return MenuScaffold(
        title: "Main Menu",
        body: Container(
          color: Colors.blue
        )
    );
    
    /*
    return Container(
      color : Colors.blue,
      child: const Text("Main Menu")
    );
    */
  }
}
