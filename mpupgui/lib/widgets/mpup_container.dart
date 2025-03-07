import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget child;
  final int colorIndex;
  final double paddingParent;
  final double paddingChild;
  final double borderRadius;
  final double sizeX;
  final double sizeY;

  const MagickaPupContainer({
    super.key,
    required this.child,
    this.colorIndex = 1,
    this.paddingParent = 15,
    this.paddingChild = 0,
    this.borderRadius = 3,
    this.sizeX = -1,
    this.sizeY = -1,
  });

  @override
  Widget build(BuildContext context) {

    final double finalWidth = sizeX < 0 ? MediaQuery.of(context).size.width : sizeX;
    final double finalHeight = sizeY < 0 ? MediaQuery.of(context).size.height : sizeY;

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

