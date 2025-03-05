import 'package:flutter/material.dart';

class MenuManager {
  static void loadMenu(var context, String menuName) {
    Navigator.pushNamedAndRemoveUntil(context, menuName, (_) => false);
  }
}
