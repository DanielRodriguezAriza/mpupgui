import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_init.dart';
import 'package:mpupgui/menus/menu_main.dart';
import 'package:mpupgui/menus/menu_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MagickaPUP GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ScreenMain(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const InitScreen(),
        "/main": (context) => const MainMenu(),
        "/settings": (context) => const SettingsMenu(),
        "/compiler": (context) => const CompilerMenu(),
        "/decompiler": (context) => const DecompilerMenu(),
      }
    );
  }
}

