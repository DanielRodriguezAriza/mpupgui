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

  const ModEntryWidget({
    super.key,
    required this.text,
    required this.path,
    required this.selected,
    required this.onSelected,
    required this.loadOrder,
    required this.setLoadOrder,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    onPressed: (){
                      setLoadOrder();
                    },
                    child: const Placeholder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MagickaPupButton(
                    level: 0,
                    useAutoPadding: false,
                    onPressed: () async {
                      await OpenFilex.open(path);
                    },
                    child: const MagickaPupText(
                      text: "...",
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
