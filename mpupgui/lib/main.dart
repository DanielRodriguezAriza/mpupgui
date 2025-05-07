import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/menus/menu_fproc_compiler.dart';
import 'package:mpupgui/menus/menu_fproc_decompiler.dart';
import 'package:mpupgui/menus/menu_init.dart';
import 'package:mpupgui/menus/menu_main.dart';
import 'package:mpupgui/menus/menu_mm.dart';
import 'package:mpupgui/menus/menu_settings.dart';
import 'package:mpupgui/test_screen.dart';
import 'package:mpupgui/utility/plain_page_router.dart';
import 'package:window_size/window_size.dart';

bool isPlatformDesktop() {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

// NOTE : Made main into an async method so that process interop
// doesn't shit its pants in flutter... yay...
void main() async {
  // Ensure that flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Perform desktop platform specific operations
  if(isPlatformDesktop()) {
    setWindowTitle("MagickaPUP GUI");
    setWindowMinSize(const Size(800, 600)); // Limit the window min size so that it cannot go below 800x600.
    // setWindowMaxSize(const Size(800, 600)); // We could limit the max size, but for now we don't really care about that, so any resolution is supported.
  }

  // Run the main app
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
    );
  }

  Widget getPage(String? pathString) {
    switch(pathString) {
      case "/": return const TestScreen();
      default: return const TestScreen();
    }
  }
}

