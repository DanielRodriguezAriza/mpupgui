import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/mpup_container_named.dart';
import 'package:mpupgui/widgets/mpup/mpup_container_simple.dart';

class MagickaPupContainer extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final int level;
  final String? text;

  const MagickaPupContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.level = 0,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    if(text == null) {
      return MagickaPupContainerSimple(
        width: width,
        height: height,
        level: level,
        child: child,
      );
    } else {
      return MagickaPupContainerNamed(
        text: text!,
        width: width,
        height: height,
        level: level,
        child: child,
      );
    }
  }
}
