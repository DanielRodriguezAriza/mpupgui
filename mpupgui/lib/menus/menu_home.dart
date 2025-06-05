import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/cache_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:http/http.dart' as dart_http;

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  // The URL to the image that is displayed on the background of the steam library for Magicka 1
  final String urlBackground = "https://cdn.akamai.steamstatic.com/steam/apps/42910/library_hero.jpg";
  final String urlTitle = "https://cdn.akamai.steamstatic.com/steam/apps/42910/logo.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        child: MagickaPupContainer(
          level: 2,
          child: Column(
            children: [
              const MagickaPupContainer(
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: getBackgroundImage(urlBackground),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                          offset: const Offset(0, -60),
                          child: SizedBox(
                            height: 300,
                            child: getBackgroundImage(urlTitle),
                            // child: Container(color: Colors.red,)
                          ),
                        ),
                      )
                    ),
                    // Play button temporarily disabled
                    // TODO : Finish implementing in a clean way!!!
                    /*
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 250,
                          height: 100,
                          child: MagickaPupButton(
                            level: 1,
                            onPressed: (){
                              // TODO : Implement quick play button logic...
                              // As well as install selection logic, similar to
                              // minecraft's launcher and stuff like that I guess...
                            },
                            child: const MagickaPupText(
                              text: "Play",
                              fontSize: 30,
                            ),
                          ),
                        ),
                      )
                    ),
                    */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<File?> getBackgroundImage(String url) {
    return FutureBuilder<File?>(
      future: CacheManager.getImage(url),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          final imageData = snapshot.data;
          if(imageData == null) {
            return Container();
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.fitHeight, // NOTE : This used to be .cover
                  image: FileImage(imageData),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
