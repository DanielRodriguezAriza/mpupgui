import 'package:flutter/material.dart';

class MenuManager {

  static int currentMenuIndex = 0;

  static void setMenu(int i) {
    currentMenuIndex = i;
  }

  static void loadMenu(var context, String menuName) {
    Navigator.pushNamedAndRemoveUntil(context, menuName, (_) => false);
  }

  static Widget getMenu() {
    return Text("The menu is $currentMenuIndex");
  }
}
