import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupContainerNamed extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final int level;
  final String text;

  const MagickaPupContainerNamed({
    super.key,
    this.child,
    this.width,
    this.height,
    this.level = 0,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    var themeData = ThemeManager.getCurrentThemeData();
    double numSegments = 3;
    double paddingBetweenSegments = themeData.padding.inner / numSegments;

    return Padding(
      padding: EdgeInsets.all(themeData.padding.outer),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBetweenSegments),
            child: Container(
              decoration: BoxDecoration(
                color: themeData.colors.image[level],
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(themeData.borderRadius),
                  bottom: const Radius.circular(0),
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
