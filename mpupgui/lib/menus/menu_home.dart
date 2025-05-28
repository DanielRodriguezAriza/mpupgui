import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:http/http.dart' as dart_http;

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  // The URL to the image that is displayed on the background of the steam library for Magicka 1
  final String backgroundURL = "https://cdn.akamai.steamstatic.com/steam/apps/42910/library_hero.jpg";
  final String backgroundPath = "./library_hero.jpg";

  // NOTE : If the image fetching fails, nothing bad really happens. The app just fails silently by getting a 404 since the
  // resource was not found, and the visual effect is the same as if no image was displayed, so that's ok for our purposes.
  // TODO : Maybe implement some caching mechanism so that we can have a local image cached once and use that from then on.

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
                      child: FutureBuilder<File?>(
                        future: getImage(backgroundPath, backgroundURL),
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
                                    fit: BoxFit.cover,
                                    image: FileImage(imageData),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // NOTE : Old method, no proper caching implemented. Just exists so that
  // you can remember that NetworkImage exists.
  /*
  ImageProvider<Object> getImage() {
    File backgroundFile = File(backgroundCachePath);
    if(backgroundFile.existsSync()) {
      return FileImage(backgroundFile);
    } else {
      return NetworkImage(backgroundURL);
    }
  }
  */

  Future<File?> getImage(String cachePath, String url) async {
    File? file = await getImageFromPath(cachePath) ?? await getImageFromNetwork(cachePath, url);
    return file;
  }

  Future<File?> getImageFromPath(String path) async {
    File file = File(path);
    bool fileExists = await file.exists();
    if(fileExists) {
      return file;
    } else {
      return null;
    }
  }

  Future<File?> getImageFromNetwork(String cachePath, String url) async {
    final response = await dart_http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final bytes = response.bodyBytes;
      File file = File(cachePath);
      await file.writeAsBytes(bytes);
      bool fileExists = await file.exists();
      if(fileExists) {
        return file;
      } // else, failed to write to target file
    } // else, failed to find the resource online
    return null;
  }

}
