import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupTextField extends StatelessWidget {

  final TextEditingController? controller;
  final VoidCallback? onEdit;

  const MagickaPupTextField({
    super.key,
    this.controller,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeManager.getCurrentThemeData();
    return TextField(
      onEditingComplete: onEdit,
      controller: controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: themeData.colors.text[0],
      ),
    );
  }
}

