import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget child;
  final int colorIndex;
  final double padding;
  final double borderRadius;

  const MagickaPupContainer({
    super.key,
    required this.child,
    this.colorIndex = 1,
    this.padding = 15,
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(padding),
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
                    padding: EdgeInsets.all(padding),
                    child : child,
                ),
              );
            }
        )
    );
  }
}

