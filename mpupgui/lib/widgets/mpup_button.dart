import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final double sizeX;
  final double sizeY;
  final double borderRadius;
  final double elevation;

  const MagickaPupButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.sizeX = 250,
    this.sizeY = 50,
    this.borderRadius = 5,
    this.elevation = 1.4, // Values between 1 and 3 look pretty nice, picking this value for now.
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){onPressed();},
      style: ElevatedButton.styleFrom(
        // backgroundColor: ThemeManager.getColor(0), // TODO : Implement colors first and then enable this setting...
        elevation: elevation,
        fixedSize: Size(sizeX, sizeY),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)
        )
      ),
      child: MagickaPupText(text: text),
    );
  }
}

