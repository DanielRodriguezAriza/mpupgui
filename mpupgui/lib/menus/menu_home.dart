import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  // The URL to the image that is displayed on the background of the steam library for Magicka 1
  final String backgroundURL = "https://cdn.akamai.steamstatic.com/steam/apps/42910/library_hero.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: MagickaPupContainer(
          level: 2,
          child: Column(
            children: [
              MagickaPupContainer(
                height: 60,
                child: Align(
                  alignment: Alignment.center,
                  child: MagickaPupText(
                    text: "Magicka Packer-Unpacker GUI",
                    fontSize: 28,
                    isBold: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(backgroundURL),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
