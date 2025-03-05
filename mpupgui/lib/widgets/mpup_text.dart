import 'package:flutter/material.dart';

class MagickaPupText extends StatelessWidget {

  final String text;

  const MagickaPupText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text
    ); // TODO : Make a more complex text class so that we can have a shadow, text outline, colors, etc... all customized to fit the app's aesthetic and looks.
  }
}
