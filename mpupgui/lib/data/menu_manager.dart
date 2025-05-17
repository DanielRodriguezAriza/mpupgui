import 'package:flutter/material.dart';

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
