import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';

class MagickaPupTextField extends StatelessWidget {

  final TextEditingController? controller;
  final VoidCallback? onEdit;
  final double fontSize;

  final double maxHeight;
  final double maxWidth;
  final double minHeight;
  final double minWidth;

  final bool numeric;

  // NOTE : TextAlign and TextAlignVertical properties:
  // To know why one is always present and the other is nullable, just
  // look at the way the properties for alignment are made in the flutter
  // baseline TextField widget class. Basically, the horizontal alignment always
  // needs to exist, so they default to Alignment.start.
  // The vertical also needs to have a value, but they instead take it as a
  // nullable reference, and use a default value defined internally as replacement.
  // Why? I don't know. But I decided to do the same so as to keep behaviour consistent with the standard.
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  const MagickaPupTextField({
    super.key,
    this.controller,
    this.onEdit,
    this.fontSize = 14,

    this.maxHeight = 20,
    this.maxWidth = double.infinity,
    this.minHeight = 0,
    this.minWidth = 0,

    this.numeric = false,

    this.textAlign = TextAlign.start,
    this.textAlignVertical,
  });

  @override
  Widget build(BuildContext context) {
    return getTextField();
  }

  Widget getTextField() {
    var themeData = ThemeManager.getCurrentThemeData();
    return TextField(
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEdit,
      controller: controller,
      keyboardType: TextInputType.text,
      inputFormatters: numeric ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ] : [],
      // textAlign: TextAlign.left,
      // textAlignVertical: TextAlignVertical.top,
      style: TextStyle(
        color: themeData.colors.text[0],
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(themeData.padding.inner, 0, themeData.padding.inner, 0),
        filled: true,
        fillColor: themeData.colors.image[0],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(themeData.borderRadius),
        ),
        // isCollapsed: true,
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          minHeight: minHeight,
          minWidth: minWidth,
        ),
      ),
    );
  }
}

