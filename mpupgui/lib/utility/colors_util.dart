import 'package:flutter/material.dart';

class ColorUtil {

  static int clamp(int value, [int min = 0, int max = 255]) {
    value = value < min ? min : value;
    value = value > max ? max : value;
    return value;
  }

  static Color modify(Color color, int amount) {
    int a = color.alpha;
    int r = clamp(color.red + amount);
    int g = clamp(color.green + amount);
    int b = clamp(color.blue + amount);
    Color ans = Color.fromARGB(a, r, g, b);
    return ans;
  }

  static Color lighten(Color color, [int amount = 20]) {
    return modify(color, amount);
  }

  static Color darken(Color color, [int amount = 20]) {
    return modify(color, -amount);
  }
}
