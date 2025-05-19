import 'dart:io';

import 'package:flutter/material.dart';

// This widget class offers a list view of elements from the file system.
// Allows displays both files and directories that match the specified condition
// to check whether they should be displayed or not.
// A directory watcher is used to update events in real time.

// TODO : Implement!!!

class MagickaPupFileSystemView extends StatefulWidget {

  final String path;
  final bool Function(Directory) filter;
  final Widget Function(Directory)? widgetConstructor;

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
