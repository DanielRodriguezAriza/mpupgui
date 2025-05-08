import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupBackground extends StatelessWidget {

  final double? width;
  final double? height;
  final int level;
  final Widget? child;

  const MagickaPupBackground({
    super.key,
    this.level = 0,
    this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeManager.getCurrentThemeData().colors.image[level],
      width: width,
      height: height,
      child: child,
    );
  }
}
