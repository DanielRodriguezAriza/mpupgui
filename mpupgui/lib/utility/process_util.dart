// Retarded utility to execute subprocesses.
// Literally, its only purpose is to mask in a relatively nice way the ugly
// windows workaround for admin privilege execution for symlinks and shit...

import 'dart:io';

import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';

// NOTE : This function is extremely unstable, actually it does not work on all windows versions, so better not to use it.
// TODO : Discard this piece of shit and delete this at some point in the future...
// if only win32 allowed us to create fucking symlinks as regular users, then none of this would be needed...
// but it seems like Windows is the most retarded OS ever made...
Future<Process> processStartOld(String executable, [List<String> arguments = const [], bool runAsAdmin = false]) async {
  runAsAdmin = Platform.isWindows ? runAsAdmin : false; // Always assume that we don't need to run as admin on any platform other than windows... yeah, dirty hack, but that's because the only thing this app needs like this is fucking symlinks and that does not require admin permissions anywhere else...
  if(runAsAdmin) {
    String exec = "powershell";
    String args = "$executable ";
    for(var s in arguments) {
      args += "\"$s\" ";
    }
    return Process.start(
      exec,
      [
        "-Command",
        "Start-Process",
        args,
        "-Verb",
        "RunAs",
      ],
      runInShell: true,
    );
  } else {
    return Process.start(
      executable,
      arguments,
      runInShell: true,
    );
  }
}

Future<Process> processStart(String executable, [List<String> arguments = const [], bool runAsAdmin = false]) async {
  if(runAsAdmin) {
    List<String> args = ["true", executable];
    args.addAll(arguments);
    return Process.start(
      pathFix(ModManager.getPathToMagickCowModManagerProxy()),
      args,
      runInShell: false,
    );
  } else {
    return Process.start(
      executable,
      arguments,
      runInShell: true,
    );
  }
}
