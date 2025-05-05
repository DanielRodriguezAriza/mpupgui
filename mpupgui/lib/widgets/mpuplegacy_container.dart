import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupLegacyContainer extends StatelessWidget {

  final Widget child;
  final int colorIndex;
  final double paddingParent;
  final double paddingChild;
  final double borderRadius;
  final double width;
  final double height;

  const MagickaPupLegacyContainer({
    super.key,
    required this.child,
    this.colorIndex = 1,
    this.paddingParent = 15,
    this.paddingChild = 0,
    this.borderRadius = 3,
    this.width = -1,
    this.height = -1,
  });

  @override
  Widget build(BuildContext context) {

    final double finalWidth = width < 0 ? MediaQuery.of(context).size.width : width;
    final double finalHeight = height < 0 ? MediaQuery.of(context).size.height : height;

    return Padding(
        padding: EdgeInsets.all(paddingParent),
        child: Container(
          width: finalWidth,
          height: finalHeight,
          decoration: BoxDecoration(
            color: ThemeManager.getColorImage(colorIndex),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(paddingChild),
            child : child,
          ),
        )
    );
  }

  // NOTE : This implementation breaks in certain situations such as having an AppBar as the parent.
  // According to online posts and bug reports, this appears to be a flutter bug, but I'm not sure.
  /*
  Widget getContainer_OLD(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(paddingParent),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: ThemeManager.getColorImage(colorIndex),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(paddingChild),
                  child : child,
                ),
              );
            }
        )
    );
  }
  */
}

/*
  NOTE : Regular widget usage vs mpup widget usage.
  In short, using mpup widgets abstracts away multiple implementation details and
  can make designing the UI a lot easier in the long run. But it is important what
  Things would look like under normal circumstances...

  // Classic / Base flutter widget way of doing things:
  // Basically: use Container mixed with Row, Column, Padding, Expanded and Flexible.

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: ThemeManager.getColorImage(2),
              child: Text("0"),
            )
          )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: ThemeManager.getColorImage(2),
              child: Text("0"),
            )
          )
        ),
      ],
    );
  }

  // MagickaPupGUI way of doing things:
  const Expanded(
      child: MagickaPupContainer(
        colorIndex: 2,
        child: MagickaPupText(text: "0"),
      )
  )
  etc...

*/

