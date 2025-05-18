import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MagickaPupBackground(
        child: MagickaPupContainer(
          child: Align(
            alignment: Alignment.topCenter,
            child: MagickaPupText(
              text: "Magicka Packer-Unpacker GUI",
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
