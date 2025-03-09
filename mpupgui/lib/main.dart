import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_init.dart';
import 'package:mpupgui/menus/menu_main.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/utility/plain_page_router.dart';

// NOTE : Made main into an async method so that process interop
// doesn't shit its pants in flutter... yay...
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner thing
      title: 'MagickaPUP GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: "/", // The init screen in this case
      onGenerateRoute: (settings) {
        return PlainPageRouter(
            page: getPage(settings.name),
            settings: settings,
        );
      },

      // NOTE : Stuff ahead corresponds to the old routing system. Just ignore it for now until I clean this mess up...
      // home: const ScreenMain(),
      /*routes: {
        "/": (context) => const InitScreen(),
        "/main": (context) => const MainMenu(),
        "/settings": (context) => const SettingsMenu(),
        "/compiler": (context) => const CompilerMenu(),
        "/decompiler": (context) => const DecompilerMenu(),
      }*/
    );
  }

  Widget getPage(String? pathString) {
    switch(pathString) {
      case "/": return const InitScreen();
      case "/main": return const MainMenu();
      case "/compiler": return const CompilerMenu();
      case "/decompiler": return const DecompilerMenu();
      case "/settings": return const SettingsMenu();
      default: return const InitScreen(); // NOTE : In the future, we could use a custom failure or 404 screen of sorts in this case, with a button to return to the main screen or whatever. For now, we just get sent back to the init screen and call it a day.
    }
  }
}

