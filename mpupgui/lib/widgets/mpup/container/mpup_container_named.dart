import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/colors_util.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupContainerNamed extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final int level;
  final String text;
  final Color? color;

  const MagickaPupContainerNamed({
    super.key,
    this.child,
    this.width,
    this.height,
    this.level = 0,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {

    var themeData = ThemeManager.getCurrentThemeData();
    double numSegments = 3;
    double paddingBetweenSegments = 0; // themeData.padding.inner / numSegments;

    var topColor = color ?? themeData.colors.image[level]; // If color is null, then set it to the theme color for the selected level.

    return Padding(
      padding: EdgeInsets.all(themeData.padding.outer),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBetweenSegments),
            child: Container(
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(themeData.borderRadius),
                  bottom: const Radius.circular(0),
                ),
                border: Border.all(
                  color: ColorUtil.darken(topColor, themeData.darkening),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(themeData.padding.inner),
                child: Row(
                  children: [
                    Expanded(
                      child: MagickaPupText(text: text),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, paddingBetweenSegments, 0, paddingBetweenSegments),
            child: Container(
              color: Colors.orange,
              height: paddingBetweenSegments * 3.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, paddingBetweenSegments, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: themeData.colors.image[level],
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: const Radius.circular(0),
                    bottom: Radius.circular(themeData.borderRadius),
                  ),
                  border: Border.all(
                    color: ColorUtil.darken(themeData.colors.image[level], themeData.darkening),
                    width: 2,
                  ),
                ),
                width: width,
                height: height,
                child: Padding(
                  padding: EdgeInsets.all(themeData.padding.inner),
                  child: child,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
