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

  final bool useAutoPadding;

  const MagickaPupButton({
    super.key,
    this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.elevation,
    this.level = 0,
    this.useAutoPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    var themeData = ThemeManager.getCurrentThemeData();
    return Padding(
      padding: EdgeInsets.all(useAutoPadding ? themeData.padding.outer : 0),
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
      //minimumSize: const Size(0, 0), // NOTE : WARNING!!! Setting the min size to 0 will fucking break all buttons and you will not be able to click on any of them, no matter what their actual size is!!!
      padding: const EdgeInsets.all(1), // Remove the extra padding for the child. Elevated buttons have an annoying default padding value which forces elements that could fit within the button's area to actually jump out of bounds and get an offset when the button is small enough. With text, it splits it on multiple lines unnecessarily. Note that setting this value to 0 breaks buttons in some cases, so we set the padding to 1 at least and that's it...
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
