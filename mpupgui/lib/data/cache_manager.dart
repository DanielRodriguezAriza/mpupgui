// This is a class whose purpose is to perform all cache related operations

import 'dart:io';
import "package:http/http.dart" as dart_http;
import 'package:mpupgui/utility/file_handling.dart';

abstract final class CacheManager {

  static String pathToCachedData = "./data/cache/";

  static Future<File?> getImage(String url) async {
    String cachePath = pathJoin(pathToCachedData, pathName(url, true));
    return cacheImage(cachePath, url);
  }

  static Future<File?> cacheImage(String cachePath, String url) async {
    File? file = await getImageFromPath(cachePath) ?? await getImageFromNetwork(cachePath, url);
    return file;
  }

  static Future<File?> getImageFromPath(String path) async {
    File file = File(path);
    bool fileExists = await file.exists();
    if(fileExists) {
      return file;
    } else {
      return null;
    }
  }

  static Future<File?> getImageFromNetwork(String cachePath, String url) async {
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
