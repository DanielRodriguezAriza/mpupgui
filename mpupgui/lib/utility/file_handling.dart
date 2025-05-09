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
