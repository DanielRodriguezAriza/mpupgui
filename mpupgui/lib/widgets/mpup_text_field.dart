import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupTextField extends StatelessWidget {

  final TextEditingController controller;

  const MagickaPupTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: ThemeManager.getColorText(0),
      ),
    );
  }
}

