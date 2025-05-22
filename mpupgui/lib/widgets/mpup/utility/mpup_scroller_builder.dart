import 'package:flutter/material.dart';

// This widget is like the regular mpup scroller widget, but this one
// uses a builder function to generate the children on demand.
// This way, the performance is increased for extremely long or potentially
// infinite scrollable lists, since we do not have to render an insane
// amount of widgets within the scrollable list.
// It's also pretty nice for stuff where each entry is generated depending on
// its index and whatnot.

class MagickaPupScrollerBuilder extends StatefulWidget {
  final ScrollController controller;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int? itemCount;

  const MagickaPupScrollerBuilder({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.itemCount,
  });

  @override
  State<MagickaPupScrollerBuilder> createState() => _MagickaPupScrollerBuilderState();
}

class _MagickaPupScrollerBuilderState extends State<MagickaPupScrollerBuilder> {
  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: widget.controller,
      child: ListView.builder(
        itemBuilder: widget.itemBuilder,
        controller: widget.controller,
        itemCount: widget.itemCount, // The itemCount is only used by the scroller to determine it's max scroll extents, so that the scroll bar can be properly resized and all that scroll logic and stuff. That's why it is not necessary, but it is good to have. If the list is infinite, it should be ok to not specify this value, that way it will generate from index 0 all the way to infinity, and the generator code should use the index to generate the logic for each entry.
      ),
    );
  }
}
