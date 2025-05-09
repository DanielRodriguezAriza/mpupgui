import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';

void writeStringToFile(String fileName, String contents) {
  File file = File(fileName);
  file.writeAsStringSync(contents);
}

String readStringFromFile(String fileName) {
  File file = File(fileName);
  return file.readAsStringSync();
}

Future<String?> pickDir() async {
  String? directory = await getDirectoryPath();
  return directory;
}

Future<List<String>?> pickFiles(bool allowMultiple, [List<String>? extensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: extensions == null ? FileType.any : FileType.custom,
    allowedExtensions: extensions,
    allowMultiple: allowMultiple,
  );
  if(result != null) {
    List<String> ans = [];
    for(var file in result.files) {
      ans.add(file.path!);
    }
    return ans;
  }
  return null;
}

// NOTE : There's probably plenty of edge cases here, but this is good enough for now.
// The input paths should not be fucked up, right...? lol!
String joinPath(String pathA, String pathB) {

  if(pathA.isEmpty) {
    return pathB;
  }

  if(pathB.isEmpty) {
    return pathA;
  }

  var cA = pathA[pathA.length - 1];
  var cB = pathB[0];

  bool hasSeparatorA = cA == '/' || cA == '\\';
  bool hasSeparatorB = cB == '/' || cB == '\\';

  if(!hasSeparatorA && !hasSeparatorB) {
    return "$pathA/$pathB";
  }

  if(hasSeparatorA && hasSeparatorB) {
    var nB = pathB.substring(1, pathB.length - 1);
    return "$pathA/$nB";
  }

  return "$pathA$pathB";
}
