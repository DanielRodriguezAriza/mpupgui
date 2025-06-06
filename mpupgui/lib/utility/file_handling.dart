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
    lockParentWindow: true,
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

Future<String?> pickFile([List<String>? extensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: extensions == null ? FileType.any : FileType.custom,
    allowedExtensions: extensions,
    allowMultiple: false,
    lockParentWindow: true,
  );
  if(result != null && result.files.isNotEmpty) {
    return result.files[0].path;
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

// region pathIsValid

// Functions to check if a given path contains characters that are not valid
// on the current system.

bool pathIsValid(String path) {
  return directoryIsValid(Directory(path)) || fileIsValid(File(path));
}

bool fileIsValid(File file) {
  try {
    String path = file.absolute.path;
    return true;
  } catch(e) {
    return false;
  }
}

bool directoryIsValid(Directory directory) {
  try {
    String path = directory.absolute.path;
    return true;
  } catch(e) {
    return false;
  }
}

// endregion

// region pathExists

bool pathExists(String path) {
  return directoryExists(Directory(path)) || fileExists(File(path));
}

bool directoryExists(Directory directory) {
  return directory.existsSync();
}

bool fileExists(File file) {
  return file.existsSync();
}

// endregion

bool isSameDriveSync(String pathA, String pathB) {
  // If on Windows:
  // We just check the drive letter.
  // Windows can only have up to 26 drive letters, anything more than that is not
  // recognised... that means that users need to merge multiple drives with something like a RAID
  // under the same mount point (the same drive letter).
  // In that case, even stuff like hardlinks work properly, because the hardlink limitation is not under
  // physical hard drives, but under the mount points / File system "units" themselves.
  return pathA[0] == pathB[0]; // BRUH...

  // If on another system:
  // TODO : Implement LOL!

  // NOTE : Checking if the mount point is the same like this by checking
  // the drive letter only works on windows!
  // on other systems, we need to use stuff like stat(), and sadly,
  // Directory.stat() does not give enough info about the inode or the deviceId
  // on dart, so we need to make a subprocess call... not gonna implement it
  // for now tho, because I don't have time, but it should be easy enough.
  // Just need to modify the code to be async so that we don't have issues...
  // And then add an isSameDriveSync version...
}

bool isSameDriveManySync(List<String> paths) {

  // If we have 0 or 1 drives on the list, then just return true cause there's
  // nothing to compare against...
  if(paths.length <= 1) {
    return true;
  }

  final String firstPath = paths[0];
  for(int i = 1; i < paths.length; ++i) {
    if(!isSameDriveSync(firstPath, paths[i])) {
      return false;
    }
  }

  return true;

  // This other alternative works AFAIK, but I wouldn't risk it considering how
  // there could exist some edge case where it breaks...
  /*
  int comparisons = 0;
  for(int i = 0; i < paths.length - 1; ++i) {
    if(isSameDriveSync(paths[i], paths[i + 1])) {
      comparisons += 1;
    }
  }

  return comparisons == paths.length - 1;
  */
}
