import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';

class MagickaPupTextField extends StatelessWidget {

  final TextEditingController? controller;
  final VoidCallback? onEdit;
  final double fontSize;

  const MagickaPupTextField({
    super.key,
    this.controller,
    this.onEdit,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return getTextField();
  }

  Widget getTextField() {
    var themeData = ThemeManager.getCurrentThemeData();
    return TextField(
      onEditingComplete: onEdit,
      controller: controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.top,
      style: TextStyle(
        color: themeData.colors.text[0],
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: themeData.colors.image[0],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(themeData.borderRadius),
        ),
      ),
    );
  }
}

