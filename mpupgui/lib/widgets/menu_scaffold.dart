import 'package:flutter/material.dart';
import '../data/theme_manager.dart';

// Wrapper class for Scaffold which will helps us define scaffolds in a consistent
// manner across the app.

class MenuScaffold extends StatelessWidget {

  final String title;
  final Widget body;

  const MenuScaffold({
    super.key,
    required this.title,
    required this.body
  });

  @override
  Widget build(BuildContext context) {
    return createScaffold();
  }

  Widget createScaffold() {
    return Scaffold(
      appBar: createAppBar(),
      body: createBody(),
      backgroundColor: ThemeManager.getColorImage(0),
    );
  }

  AppBar createAppBar() {
    return AppBar(
      title: Text(
        title
      )
    );
  }

  Widget createBody() {
    return Container(
      child : body
    );
  }
}

