import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget child;
  final int colorIndex;

  const MagickaPupContainer({
    super.key,
    required this.child,
    this.colorIndex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
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

