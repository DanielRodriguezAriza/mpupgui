import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';
import 'package:open_filex/open_filex.dart';

class ModEntryWidget extends StatelessWidget {

  final String text;
  final String path;
  final bool selected;
  final int loadOrder;
  final VoidCallback onSelected;
  final VoidCallback setLoadOrder;
  final VoidCallback setLoadOrderUp; // decrease the load order (order--)
  final VoidCallback setLoadOrderDown; // increase the load order (order++)

  const ModEntryWidget({
    super.key,
    required this.text,
    required this.path,
    required this.selected,
    required this.onSelected,
    required this.loadOrder,
    required this.setLoadOrder,
    required this.setLoadOrderUp,
    required this.setLoadOrderDown,
  });

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
  
  Widget getWidget() {
    final AppThemeData themeData = ThemeManager.getCurrentThemeData();
    final Widget child = selected ? Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: themeData.colors.image[3],
        borderRadius: BorderRadius.circular(100),
      ),
    ) : Container();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: MagickaPupContainer(
          level: 1,
          child: Row(
            children: [
              Expanded(
                // flex: 9,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: MagickaPupText(
                    isBold: true,
                    text: text,
                    fontSize: 18,
                  ),
                ),
              ),
              /*
              Padding(
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: MagickaPupText(
                    isBold: true,
                    text: "$loadOrder",
                    fontSize: 18,
                  ),
                ),
              ),
              */
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: SizedBox(
                  width: 120, // TODO : (obvious joke is obvious) VERY IMPORTANT!!! FIX ASAP!!!! Eventually fix the issue of text that will not fit once the number gets large enough... for now, over 99999999999 mods can be added and still fit in the same line without any issues... from there, we have double the length in characters to fit in the second line until we truly run out of space, but that just looks ugly!!! So yeah, FIX ASAP!!!! /s
                  height: 50,
                  child: MagickaPupButton(
                    useAutoPadding: false,
                    onPressed: (){
                      setLoadOrder();
                    },
                    child: MagickaPupText(
                      isBold: true,
                      text: "$loadOrder", // Yes, really, I've tested it and the number can fit in a single line up to 99999999999... that's over 99 AMERICAN billion! or over 99 thousand million if you prefer the European billion, like normal people do!
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: SizedBox(
                  width: 50 / 2,
                  height: 50,
                  child: Column(
                    children: [
                      Expanded(
                        child: MagickaPupButton(
                          useAutoPadding: false,
                          onPressed: (){
                            setLoadOrderUp();
                          },
                          child: const MagickaPupText(
                            text: "-",
                            isBold: true,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MagickaPupButton(
                          useAutoPadding: false,
                          onPressed: (){
                            setLoadOrderDown();
                          },
                          child: const MagickaPupText(
                            text: "+",
                            isBold: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () async {
                      await OpenFilex.open(path);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image: AssetImage("assets/images/mpup_icon_folder.png"),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: onSelected,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
