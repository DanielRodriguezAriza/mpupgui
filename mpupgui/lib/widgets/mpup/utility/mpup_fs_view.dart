import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:open_filex/open_filex.dart';
import 'package:watcher/watcher.dart';

// This widget class offers a list view of elements from the file system.
// Allows displays both files and directories that match the specified condition
// to check whether they should be displayed or not.
// A directory watcher is used to update events in real time.

class MagickaPupFileSystemView extends StatefulWidget {

  final String path;
  final bool Function(FileSystemEntity) filter;
  final Widget Function(FileSystemEntity)? widgetConstructor;
  final int Function(FileSystemEntity, FileSystemEntity)? sortFunction;

  const MagickaPupFileSystemView({
    super.key,
    required this.path,
    required this.filter,
    this.widgetConstructor,
    this.sortFunction,
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
    return getWidget();
  }

  // Function to construct the main widget
  Widget getWidget() {
    return MagickaPupScroller(
      controller: scrollController,
      children: getEntryWidgets(),
    );
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
        entries = dir.listSync().where(widget.filter).toList();
        if(widget.sortFunction != null) {
          entries.sort(widget.sortFunction);
        }
      }
    });
  }

  // Default function to generate the widget of an entry.
  // If the user provides a custom function, this one is not used.
  // Otherwise, this is the function that is invoked to populate the child widgets.
  Widget getEntryWidgetDefault(FileSystemEntity entry) {
    final String name = pathName(entry.path);
    final String path = entry.path;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: MagickaPupContainer(
          level: 1,
          child: Row(
            children: [
              Expanded(
                // flex: 9,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: MagickaPupText(
                    isBold: true,
                    text: name,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: MagickaPupButton(
                  level: 0,
                  useAutoPadding: false,
                  onPressed: () async {
                    await OpenFilex.open(path);
                  },
                  child: const MagickaPupText(
                    text: "...",
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get a list of all of the entry widgets
  List<Widget> getEntryWidgets() {
    var fn = getEntryWidgetDefault;
    if(widget.widgetConstructor != null) {
      fn = widget.widgetConstructor!;
    }
    return List<Widget>.from(entries.map((entry) => fn(entry)));
  }

}
