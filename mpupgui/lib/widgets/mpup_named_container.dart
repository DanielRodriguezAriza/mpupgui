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

    const double borderRadius = 5;

    // NOTE : This container is actually useless in this case, but I'm keeping it just in case I need it in the future lol...
    // The reason why this is here is that this Container used to be an Expanded. The problem is that
    // Containers can be located directly as children below Padding widgets / blocks.
    // Expanded cannot do so, as it goes literally against what the padding does...
    // expanded tries to expand, while padding tries to add padding. This causes the program to silently error
    // so it's kinda harmless for the most part, but it is better to actually correctly handle padding...
    // The correct structure is usually something like this: Row / Column / WhateverParent(child: Expanded(child:ContainerType(child:Padding(child:WhateverIWanted(etc...)))))
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, paddingBetweenSegmentsHalf),
            child: Container(
              decoration: BoxDecoration(
                color: ThemeManager.getColorImage(colorIndex),
                borderRadius: const BorderRadiusDirectional.vertical(
                    top: Radius.circular(borderRadius),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(borderRadius),
                    ),
                    color: ThemeManager.getColorImage(colorIndex),
                  ),
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
