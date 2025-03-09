import 'package:flutter/material.dart';
import 'package:mpupgui/data/menu_manager.dart';
import 'package:mpupgui/data/settings_manager.dart';

// Widget menu class responsible for handling program initialization related
// logic and operations.

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      SettingsManager.loadSettings();
      MenuManager.loadMenu(context, "/main"); // Start by loading the "main" menu.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black // Shows a simple black screen while the initialization process is taking place.
    );
  }
}

