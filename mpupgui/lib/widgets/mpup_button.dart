import 'package:flutter/material.dart';

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
      child: Text(text),
    );
  }
}

