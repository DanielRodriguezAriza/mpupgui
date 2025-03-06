import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

import '../data/theme_manager.dart';

class MagickaPupButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final double sizeX;
  final double sizeY;
  final double borderRadius;
  final double elevation;
  final bool autoSize;
  final int colorIndex;

  const MagickaPupButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.sizeX = 250,
    this.sizeY = 50,
    this.borderRadius = 3,
    this.elevation = 1.4, // Values between 1 and 3 look pretty nice, picking this value for now.
    this.autoSize = false,
    this.colorIndex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return getElevatedButton();
  }

  Widget getElevatedButton() {
    return ElevatedButton(
      onPressed: (){onPressed();},
      style: getElevatedButtonStyle(),
      child: MagickaPupText(text: text),
    );
  }

  ButtonStyle getElevatedButtonStyle() {
    final styleWithCustomSize = ElevatedButton.styleFrom(
      fixedSize: Size(sizeX, sizeY),
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      backgroundColor: ThemeManager.getColorImage(colorIndex)
    );

    final styleWithAutoSize = ElevatedButton.styleFrom(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      backgroundColor: ThemeManager.getColorImage(colorIndex)
    );

    if(autoSize) {
      return styleWithAutoSize;
    } else {
      return styleWithCustomSize;
    }
  }
}

