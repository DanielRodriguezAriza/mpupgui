import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/colors_util.dart';

class MagickaPupContainerSimple extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final int level;

  const MagickaPupContainerSimple({
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

    return Padding(
      padding: EdgeInsets.all(themeData.padding.outer),
      child: Container(
          decoration: BoxDecoration(
            color: themeData.colors.image[level],
            borderRadius: BorderRadius.circular(themeData.borderRadius),
            border: Border.all(
              color: ColorUtil.darken(themeData.colors.image[level], themeData.darkening),
              width: 2,
            )
          ),
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.all(themeData.padding.inner),
            child: child,
          ),
        )
    );
  }
}
