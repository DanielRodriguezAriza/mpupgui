import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const MagickaPupButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){onPressed();},
      child: MagickaPupText(text: text),
    );
  }
}

