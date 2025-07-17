// Retarded utility to execute subprocesses.
// Literally, its only purpose is to mask in a relatively nice way the ugly
// windows workaround for admin privilege execution for symlinks and shit...

import 'dart:io';

Future<Process> processStart(String executable, [List<String> arguments = const [], bool runAsAdmin = false]) async {
  runAsAdmin = Platform.isWindows ? runAsAdmin : false; // Always assume that we don't need to run as admin on any platform other than windows... yeah, dirty hack, but that's because the only thing this app needs like this is fucking symlinks and that does not require admin permissions anywhere else...
  if(runAsAdmin) {
    String exec = "powershell";
    String args = "";
    for(var s in arguments) {
      args += "$s ";
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
