import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/utility/colors_util.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class MagickaPupButton extends StatelessWidget {
  final Widget? child;
  final Function? onPressed;
  final double? width;
  final double? height;
  final double? elevation;
  final int level;

  const MagickaPupButton({
    super.key,
    this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.elevation,
    this.level = 0,
  });

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    var themeData = ThemeManager.getCurrentThemeData();
    return Padding(
      padding: EdgeInsets.all(themeData.padding.outer),
      child: getButtonWidget(context, themeData),
    );
  }

  Widget getButtonWidget(BuildContext context, AppThemeData themeData) {

    Function buttonFunction = onPressed ?? (){print("Button was pressed!");};
    Widget buttonChild = child ?? const MagickaPupText(text:"Button", isBold: true, fontSize: 20);

    return ElevatedButton(
      onPressed: (){buttonFunction();},
      style: getButtonStyle(context, themeData),
      /*child: Padding(
        padding: EdgeInsets.all(themeData.padding.inner),
        child: buttonChild,
      ),*/
      child: buttonChild,
    );
  }

  Size? getFixedSize(BuildContext context) {
    var defaultWidth = MediaQuery.of(context).size.width;
    var defaultHeight = MediaQuery.of(context).size.height;
    return Size(width ?? defaultWidth, height ?? defaultHeight);
  }

  ButtonStyle getButtonStyle(BuildContext context, AppThemeData themeData) {
    var fixedSize = getFixedSize(context);
    return ElevatedButton.styleFrom(
      fixedSize: fixedSize,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeData.borderRadius),
      ),
      side: BorderSide(
        color: ColorUtil.darken(themeData.colors.image[level]),
        width: 2, // Hardcoded for now...
      ),
      backgroundColor: themeData.colors.image[level],
    );
  }
}
