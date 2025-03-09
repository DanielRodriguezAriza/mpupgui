import 'package:flutter/material.dart';

import '../data/theme_manager.dart';

// NOTE : This is a simple wrapper class for the default Text() widget.
// It allows making a more complex text class so that we can have a shadow,
// text outline, colors, etc...
// all customized to fit the app's aesthetic and looks.
class MagickaPupText extends StatelessWidget {

  final String text;
  final int colorIndex;
  final bool isSelectable;
  final bool isBold;
  final bool isMonospace;
  final double fontSize;

  const MagickaPupText({
    super.key,
    required this.text,
    this.colorIndex = 0,
    this.isSelectable = false,
    this.isBold = false,
    this.isMonospace = false,
    this.fontSize = 14, // NOTE : The default for flutter's TextStyle is to use 14 logical pixels.
  });

  @override
  Widget build(BuildContext context) {
    return getText();
  }

  Widget getText() {
    if(isSelectable) {
      return SelectableText(
          text,
          style: getStyle()
      );
    } else {
      return Text(
        text,
        style: getStyle()
      );
    }
  }

  TextStyle getStyle() {

    final Color color = ThemeManager.getColorText(colorIndex);
    final FontWeight fontWeight = isBold ? FontWeight.bold : FontWeight.normal;
    final String fontFamily = isMonospace ? "consolas" : "roboto"; // NOTE : The default font that is used by flutter is roboto.

    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      fontSize: fontSize
    );
  }
}
