import 'package:flutter/material.dart';
import 'package:mpupgui/screens/screen_init.dart';
import 'package:mpupgui/screens/screen_main.dart';

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
        "/": (context) => const ScreenInit(),
        "/main": (context) => ScreenMain()
      }
    );
  }
}

