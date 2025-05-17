import 'package:flutter/material.dart';

// NOTE : All of these static methods could actually just be free-standing functions...
// But we're leaving it like this due to historical reasons, and being too lazy / having no time to fix this shit...
abstract final class MenuManager {

  // Load directly the specified menu
  static void loadMenu(BuildContext context, String menuName) {
    Navigator.pushNamedAndRemoveUntil(context, menuName, (_) => false);
  }

  // Push the specified menu to enter it while keeping in memory the previously entered menu(s)
  static void pushMenu(BuildContext context, String menuName) {
    Navigator.pushNamed(context, menuName);
  }

  // Exit the current menu and go back to the previous one (if possible)
  static void popMenu(BuildContext context) {
    if(Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
