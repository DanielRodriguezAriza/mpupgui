import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/providers/mm_provider_profile.dart';
import 'package:mpupgui/data/settings_manager.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_init.dart';
import 'package:mpupgui/menus/menu_main.dart';
import 'package:mpupgui/menus/mod_manager/menu_mm.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/menus/mod_manager/profile/menu_mm_profile_entry.dart';
import 'package:mpupgui/menus/test/test_screen.dart';
import 'package:mpupgui/utility/plain_page_router.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

bool isPlatformDesktop() {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

void ensureDirectoryExists(String path) {
  Directory dir = Directory(path);
  if(!dir.existsSync()) {
    dir.createSync();
  }
}

void initFlutterApp() {
  // Ensure that flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Perform desktop platform specific operations
  if(isPlatformDesktop()) {
    setWindowTitle("MagickaPUP GUI");
    // NOTE : The 1200 x 825 size limit was picked based on the limit that github desktop has. I eyeballed it more or less to look the same. Not sure why they picked this resolution as the min limit, but I do think it does look pretty nice for a tool GUI, so yeah, maybe it's just a rule of cool thing, idk :P
    setWindowMinSize(const Size(800, 600)); // Limit the window min size so that it cannot go below Width x Height.
    // setWindowMaxSize(const Size(800, 600)); // We could limit the max size, but for now we don't really care about that, so any resolution is supported.
  } // NOTE : No other platform should ever be chosen other than desktop systems (eg: no web, no android, no ios, etc...) since these tools cannot be executed outside of a desktop environment and they do not make sense anywhere else anyway.

  // Create the data directories if they do not exist yet.
  // Usually performed on first boot of the app.
  List<String> dirs = [
    // Data
    "./data",

    // Cache
    "./data/cache",

    // Mod Manager
    "./data/mm",
    "./data/mm/installs",
    "./data/mm/mods",
    "./data/mm/profiles",

    // Tools
    "./data/tools/mpup",
    "./data/tools/mcow-mm",
  ];
  // Create each of the directories if they do not exist
  for(var dir in dirs) {
    ensureDirectoryExists(dir);
  }

  // Initialize app data
  SettingsManager.loadSettings();
}

void runFlutterApp() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>ModManagerProfileProvider(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

// NOTE : Made main into an async function so that process interop
// doesn't cause flutter to shit its pants... yay...
void main() async {
  // Initialize the main app
  initFlutterApp();

  // Run the main app
  runFlutterApp();
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
      initialRoute: "/main", // The init screen in this case
      onGenerateRoute: (settings) {
        return PlainPageRouter(
            page: getPage(settings.name),
            settings: settings,
        );
      },
    );
  }

  Widget getPage(String? pathString) {
    switch(pathString) {
      case "/main": return const MainMenu();
      default: return const MainMenu(); // If lost, return to main menu
    }
  }
}
