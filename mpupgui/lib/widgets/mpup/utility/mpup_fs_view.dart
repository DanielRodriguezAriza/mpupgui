import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:open_filex/open_filex.dart';
import 'package:watcher/watcher.dart';

// This widget class offers a list view of elements from the file system.
// Allows displays both files and directories that match the specified condition
// to check whether they should be displayed or not.
// A directory watcher is used to update events in real time.

// TODO : Implement!!!

class MagickaPupFileSystemView extends StatefulWidget {

  final String path;
  final bool Function(FileSystemEntity) filter;
  final Widget Function(FileSystemEntity)? widgetConstructor;

  const MagickaPupFileSystemView({
    super.key,
    required this.path,
    required this.filter,
    this.widgetConstructor,
  });

  @override
  State<MagickaPupFileSystemView> createState() => _MagickaPupFileSystemViewState();
}

class _MagickaPupFileSystemViewState extends State<MagickaPupFileSystemView> {

  final ScrollController scrollController = ScrollController();
  List<FileSystemEntity> entries = [];
  late DirectoryWatcher watcher;

  @override
  void initState() {
    super.initState();
    watcher = DirectoryWatcher(widget.path);
    watcher.events.listen((event){
      loadEntries();
    });
    loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // Function to load the FS entries found within the specified path
  void loadEntries() {
    // NOTE : We can either iterate all entries and just say if(entry is Directory)
    // or use the .whereType<T>() function to filter and get only the entries that are of the specified type.

    if(!mounted) {
      // Weird fix for an issue with directory watcher where the watcher gets a notification state
      // before the widget even exists!
      // Or maybe this has to do with the fact that init state calls loadEntries, which calls a setState
      // on the fucking initState function??? I have no idea!!! FUCKING FLUTTER!!!!
      return;
    }

    setState(() {
      // Reset the state
      entries.clear();

      // Load the new entries
      var dir = Directory(widget.path);
      if(dir.existsSync()) {
        // Only pick the entries that return through through the filter function
        var entries = dir.listSync().where(widget.filter);
      }
    });
  }

}
