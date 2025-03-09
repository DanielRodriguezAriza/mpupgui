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

  const MagickaPupText({
    super.key,
    required this.text,
    this.colorIndex = 0,
    this.isSelectable = false,
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
    return TextStyle(
      color: ThemeManager.getColorText(colorIndex)
    );
  }
}
