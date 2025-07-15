import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:open_filex/open_filex.dart';

class InstallEntryWidget extends StatelessWidget {

  final String text;
  final String path;
  final bool selected;
  final VoidCallback onSelected;

  const InstallEntryWidget({
    super.key,
    required this.text,
    required this.path,
    required this.selected,
    required this.onSelected,
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
