import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mpupgui/data/mod_manager.dart';

enum ProfileProcessState {
  none,
  running,
  success,
  failure,
}

class ProfileProcessInfo {
  final String name;
  final Process process;
  ProfileProcessState state;

  ProfileProcessInfo({
    required this.name,
    required this.process,
    required this.state,
  });
}

class ModManagerProfileProvider extends ChangeNotifier {
  List<ProfileProcessInfo> processes = [];

  Future<void> startProcess(String profileDirectoryName) async {
    for(var process in processes) {
      if(process.name == profileDirectoryName) {
        return; // Don't do anything, the process is already going at it.
      }
    }
    // Start the internal process and add it to the list
    String processName = ModManager.getPathToMagickCowModManager();
    List<String> args = [
      "-pi", ModManager.getPathToInstalls(),
      "-pm", ModManager.getPathToMods(),
      "-pp", ModManager.getPathToProfiles(),
      "-r", profileDirectoryName,
    ];
    return await _startProcessInternal(profileDirectoryName, processName, args);
  }

  Future<void> _startProcessInternal(String dirName, String processName, List<String> args) async {
    final process = await Process.start(processName, args, runInShell: true);
    var processInfo = ProfileProcessInfo(
      name: dirName,
      process: process,
      state: ProfileProcessState.running,
    );
    processes.add(processInfo);

    notifyListeners();

    process.stdout.drain();
    process.stderr.drain();

    int exitCode = await process.exitCode;
    processInfo.state = exitCode == 0 ? ProfileProcessState.success : ProfileProcessState.failure;

    processes.remove(processInfo);

    notifyListeners();
  }
}
