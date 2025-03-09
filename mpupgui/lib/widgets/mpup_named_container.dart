import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

// NOTE : Basically, same as the mpup container class, but it has a card-like
// layout with a top section where a name for the field / card / container is
// displayed, and a bottom larger section where the actual container's contents
// will be located.
class MagickaPupNamedContainer extends StatelessWidget {

  final String text;
  final Widget child;
  final int colorIndex;

  const MagickaPupNamedContainer({
    super.key,
    required this.text,
    required this.child,
    this.colorIndex = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15), // NOTE : Default padding is 15 in mpupgui's layout, maybe make this an external thing rather than hardcoding it here?
      child: getContainer(context)
    );
  }

  Widget getContainer(BuildContext context) {

    const double paddingBetweenSegments = 5;
    const double paddingBetweenSegmentsHalf = paddingBetweenSegments / 2;

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, paddingBetweenSegmentsHalf),
            child: Container(
              decoration: BoxDecoration(
                color: ThemeManager.getColorImage(colorIndex),
                borderRadius: const BorderRadiusDirectional.vertical(
                    top: Radius.circular(5),
                    bottom: Radius.circular(0)
                )
              ),
              // color: ThemeManager.getColorImage(colorIndex),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: MagickaPupText(text: text)
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, paddingBetweenSegmentsHalf, 0, 0),
                child: Container(
                  color: ThemeManager.getColorImage(colorIndex),
                  width: MediaQuery.of(context).size.width,
                  child: Container(child: child),
                ),
              )
          )
        ],
      )
    );
  }
}
