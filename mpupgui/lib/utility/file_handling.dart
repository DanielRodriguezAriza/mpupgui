import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';

import 'package:path/path.dart' as dart_path;

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

String pathJoin(String pathA, String pathB) {
  return dart_path.join(pathA, pathB);
}

String pathJoinMany(List<String> paths) {
  return dart_path.joinAll(paths);
}

String pathName(String path, [bool includeExtension = false]) {
  // NOTE : Trailing separators are already ignored by the library anyway,
  // so no need to worry about that.
  if(includeExtension) {
    return dart_path.basename(path);
  } else {
    return dart_path.basenameWithoutExtension(path);
  }
}

String pathExtension(String path) {
  return dart_path.extension(path);
}
