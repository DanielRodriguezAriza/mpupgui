import 'package:flutter/material.dart';

// NOTE : This is a really simple aux utility class that describes the layout of
// a simple scrollable area in MagickaPupGUI.
// Honestly, it could be like the Expanded()s which I just add them manually
// wherever they are needed... but I just find the whole process of writing this
// to be kind of a hassle, so I treat it like the MagickaPupButton class and
// follow the same philosophy (sort of?) here.

class MagickaPupScroller extends StatefulWidget {
  final ScrollController controller;
  final List<Widget> children;

  const MagickaPupScroller({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<MagickaPupScroller> createState() => _MagickaPupScrollerState();
}

class _MagickaPupScrollerState extends State<MagickaPupScroller> {
  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: widget.controller,
      child: ListView(
        controller: widget.controller,
        children: widget.children,
      ),
    );
  }
}
