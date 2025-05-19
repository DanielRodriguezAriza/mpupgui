import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpupgui/data/mod_manager.dart';
import 'package:mpupgui/utility/file_handling.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import "package:open_filex/open_filex.dart";
import 'package:watcher/watcher.dart';

class ModManagerMenuGenericListDisplayAction {
  final String name;
  final Function action;

  const ModManagerMenuGenericListDisplayAction({
    required this.name,
    required this.action,
  });
}

class ModManagerMenuGenericListDisplay extends StatefulWidget {
  final String name; // Display name of the container area.
  final bool Function(Directory) directoryFilter; // Function that filters whether a directory is valid or not.
  final String Function() directoryGetter;
  final Widget Function(String name, String path)? widgetConstructor;
  final List<ModManagerMenuGenericListDisplayAction>? additionalButtons;

  const ModManagerMenuGenericListDisplay({
    super.key,
    required this.name,
    required this.directoryFilter,
    required this.directoryGetter,
    this.widgetConstructor,
    this.additionalButtons,
  });

  @override
  State<ModManagerMenuGenericListDisplay> createState() => _ModManagerMenuGenericListDisplayState();
}

class _ModManagerMenuGenericListDisplayState extends State<ModManagerMenuGenericListDisplay> {

  final ScrollController controller = ScrollController();
  int entryCount = 0;
  List<String> entryNames = [];
  List<String> entryPaths = [];

  late DirectoryWatcher watcher;

  @override
  void initState() {
    super.initState();
    watcher = DirectoryWatcher(widget.directoryGetter()); // NOTE : Requires widget to be reconstructed for the path to be updated...
    watcher.events.listen((event){
      loadEntries();
    });
    loadEntries();
  }

  void openRootDirectory() {
    OpenFilex.open(widget.directoryGetter());
  }

  bool isValidDirectory(Directory directory) {
    return widget.directoryFilter(directory);
  }

  // NOTE : We can either iterate all entries and just say if(entry is Directory)
  // or use the .whereType<T>() function to filter and get only the entries that are of the specified type.
  void loadEntries() {
    if(!mounted) {
      // Weird fix for an issue with directory watcher where the watcher gets a notification state
      // before the widget even exists!
      // Or maybe this has to do with the fact that init state calls loadEntries, which calls a setState
      // on the fucking initState function??? I have no idea!!! FUCKING FLUTTER!!!!
      return;
    }

    setState(() {
      // Reset the state
      entryCount = 0;
      entryNames.clear();
      entryPaths.clear();

      // Load the new entries
      var dir = Directory(widget.directoryGetter());
      if(dir.existsSync()) {
        var entries = dir.listSync().whereType<Directory>();
        for(var entry in entries) {
          if(isValidDirectory(entry)) {
            entryNames.add(pathName(entry.path));
            entryPaths.add(entry.path);
            entryCount += 1;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        level: 0,
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                height: 60,
                text: "Actions",
                level: 2,
                child: Row(
                  children: getActionButtonWidgets(),
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: widget.name,
                level: 2,
                child: MagickaPupScroller(
                  controller: controller,
                  children: getEntriesWidgets(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getActionButtonWidget(String text, Function? action) {
    return Expanded(
      child: MagickaPupButton(
        onPressed: (){
          if(action != null) {
            action();
          }
        },
        child: MagickaPupText(
          text: text,
        ),
      ),
    );
  }

  List<Widget> getActionButtonWidgets() {
    List<Widget> ans = [];
    List<Widget> widgets = [
      // getActionButtonWidget("Add new Install", null),
      getActionButtonWidget("Open Directory", openRootDirectory),
      getActionButtonWidget("Refresh", loadEntries),
    ];
    if(widget.additionalButtons != null) {
      for(var buttonData in widget.additionalButtons!) {
        var widget = getActionButtonWidget(buttonData.name, buttonData.action);
        ans.add(widget);
      }
    }
    ans += widgets;
    return ans;
  }

  List<Widget> getEntriesWidgets() {
    var fn = widget.widgetConstructor?? getEntryWidget;
    List<Widget> ans = [];
    for(int i = 0; i < entryCount; ++i) {
      ans.add(fn(entryNames[i], entryPaths[i]));
    }
    return ans;
  }

  Widget getEntryWidget(String name, String path) {
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
}
