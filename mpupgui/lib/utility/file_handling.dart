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

// region Path Fixes

// NOTE : Notes regarding path separator behaviour.
// Path separators are very important to get right for proper program behaviour.
// For instance, nowadays on Windows, forward slash separator ('/') is considered
// valid even tho it classically used the back slash separator ('\').
// Still, despite that, executable paths don't play well with relative paths
// that use non-standard separators.
// For example, "./someExecutable" is valid for execution on Linux, but not on
// Windows. To make it valid, you should use ".\someExecutable". Also, back slash
// paths don't work on Unix systems, since back slash is considered a valid
// character for file system entities to contain (valid char for file names and
// dir names).
// A fix could be to make a function that fixes up the path separators, but
// it could only be guaranteed to work on Windows, since there, both '\' and '/'
// are considered path separators. On UNIX systems such as Linux tho, only '/' is
// a valid path separator, and '\' is just a regular char for paths, which means
// that just blindly replacing all back slashes for forward slashes would not be
// a proper solution on Linux.
// It is for that reason that the only proper way to solve this issue is for
// users to input the correct paths on their input fields.
// Still, we can try to implement a fixup function that can try to fix paths
// on each platform as much as possible so that we can be as lenient as possible
// without introducing broken behaviour.
// That is the purpose of the following function, but too many issues can
// be introduced by it, so maybe it should be completely discarded... just write
// the correct paths instead dude, this is user error and that's it, simple as that!
// Use the following function at your own discretion, if issues come up, fuck you, deal with it!
// A "better" compromise could be made to actually just not support files in Unix systems that
// contain backslashes in the name since Magicka uses XNA and is thus heavily tied by Microsoft's way of doing things.
String pathSeparatorFix(String path) {
  if(Platform.pathSeparator == "\\") {
    return path.replaceAll("/", "\\"); // literally valid only because on Windows "/" is not a valid char for a file or dir name lol...
  }
  return path;
}

// lol...
String pathFix(String path) {
  String pathString = path;
  pathString = pathSeparatorFix(pathString);
  pathString = Directory(pathString).absolute.path;

  if((Platform.isWindows && pathString.endsWith("\\")) || pathString.endsWith("/")) {
    // Remove the last "\" or "/" separator char.
    // This is used to make sure that when we execute subprocesses with paths that end in a separator,
    // we don't have any issues where the backslash is interpreted as some sort of escape char.
    // For example, mcow-mm -pi "C:\" -pm "D:\SomeOtherPath" breaks because "C:\" is interpreted as \" being a escape char,
    // so the actual arg string read by the system is "C:\" -pm", which is not correct, thus breaking the command.
    // This can be fixed when running in shell by either using C:\, C:, "C:\\" or "C:"
    // Since paths with spaces require quotes, the most simple and generic solution is to just remove the extra backslash and that's it.
    // We also remove final forward slashes since they are not necessary, but they don't have this issue.
    // Obviously we must also ensure that platforms where "\" is a valid char for a path are not fucked with, so there, the user
    // should be responsible for properly escaping their strings...
    pathString = pathString.substring(0, pathString.length - 1);
  }
  // here we can add other function calls when we need to fix other stuff about our paths...
  return pathString;
}

// endregion

// Get a relative path string from a root and a target path.
// The root string contains the common root path of both strings.
// The target string contains the path which we want to convert into a relative path.
// Example: pathRelative("/root/thing/", "root/thing/joe_mama.png") => "./joe_mama.png"
String pathRelative(String root, String target) {
  return dart_path.relative(target, from: root);
}

String pathCurrentGet() {
  // Directory.current is broken on some platforms, so we can use
  // Directory(".") or Directory("") instead... weird, since according to
  // the docs, Directory(some_relative_path) should be appended to
  // the string given by Directory.current, but it does not appear to be
  // the case on some platforms for some reason...
  Directory dir = Directory("");
  String path = dir.absolute.path;
  return path;
}
