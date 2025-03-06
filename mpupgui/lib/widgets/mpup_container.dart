import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget child;
  final int colorIndex;
  final double padding;

  const MagickaPupContainer({
    super.key,
    required this.child,
    this.colorIndex = 1,
    this.padding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(padding),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                color: ThemeManager.getColorImage(colorIndex),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: child,
              );
            }
        )
    );
  }
}

