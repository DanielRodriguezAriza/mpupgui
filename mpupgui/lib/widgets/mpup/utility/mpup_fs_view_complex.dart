import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:open_filex/open_filex.dart';
import 'package:watcher/watcher.dart';

// TODO : Finish implementing this shit... or just remove it and make yourself a happier person...
// TODO : Really, just kill this fucking class! The logic is not even worth it!
// MagickaPup file system view with selectable and ordering controls.

class MagickaPupAdvancedFSViewEntry {
  late FileSystemEntity entry;
  late bool selected;
  late int order;
}

class MagickaPupAdvancedFSView extends StatefulWidget {

  // The list of entries is controlled externally for greater control
  // Note that all of this stuff could maybe be modified in the future to make
  // use of a custom Controller-type class like the scroll controller and the
  // text controller and whatnot... so we'd have controller.entries to access
  // this data.
  final List<MagickaPupAdvancedFSViewEntry> entries;

  // Other properties
  final String path;
  final bool Function(FileSystemEntity) filter;
  final Widget Function(MagickaPupAdvancedFSViewEntry)? widgetConstructor;
  final void Function(List<MagickaPupAdvancedFSViewEntry>)? onUpdate;

  const MagickaPupAdvancedFSView({
    super.key,
    required this.path,
    required this.entries,
    required this.filter,
    this.widgetConstructor,
    this.onUpdate,
  });

  @override
  State<MagickaPupAdvancedFSView> createState() => _MagickaPupAdvancedFSViewState();
}

class _MagickaPupAdvancedFSViewState extends State<MagickaPupAdvancedFSView> {

  final ScrollController scrollController = ScrollController();
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
      List<FileSystemEntity> tempEntries = [];
      List<MagickaPupAdvancedFSViewEntry> ans = [];

      MagickaPupAdvancedFSViewEntry generateEntry(FileSystemEntity e) {
        MagickaPupAdvancedFSViewEntry ans = MagickaPupAdvancedFSViewEntry();
        ans.entry = e;
        return ans;
      }

      // Load the new entries
      var dir = Directory(widget.path);
      if(dir.existsSync()) {
        // Only pick the entries that return through through the filter function
        tempEntries = dir.listSync().where(widget.filter).toList();

        // Update the list of entries
        // If an entry was already there, do not remove it. Preserve load order.
        // If an entry is now missing, get rid of it.
        for(var entry in widget.entries) {
          if(tempEntries.contains(entry.entry)) {
            MagickaPupAdvancedFSViewEntry newEntry = MagickaPupAdvancedFSViewEntry();
            newEntry.entry = entry.entry;
            newEntry.order = entry.order;
            newEntry.selected = entry.selected;
            ans.add(newEntry);
          }
        }
      }
    });

    if(widget.onUpdate != null) {
      widget.onUpdate!(widget.entries!);
    }
  }

  // Default function to generate the widget of an entry.
  // If the user provides a custom function, this one is not used.
  // Otherwise, this is the function that is invoked to populate the child widgets.
  Widget getEntryWidgetDefault(MagickaPupAdvancedFSViewEntry entry) {
    final String name = pathName(entry.entry.path);
    final String path = entry.entry.path;
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
    return List<Widget>.from(widget.entries.map((entry) => fn(entry)));
  }

}
