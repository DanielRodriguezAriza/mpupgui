import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final int level;

  const MagickaPupContainer({
    super.key,

    // Nullable properties.
    // No assignment means that it is initialized to null by default. We don't use explicit assignment to null to a
    // nullable type because it is considered redundant by Flutter standards since that is its default value.
    this.child,
    this.width,
    this.height,
    this.level = 0,
  });

  @override
  Widget build(BuildContext context) {

    var themeData = ThemeManager.getCurrentThemeData();

    return Container(
      decoration: BoxDecoration(
        color: themeData.colors[AppThemeType.image]![level],
        borderRadius: BorderRadius.circular(themeData.borderRadius)
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
