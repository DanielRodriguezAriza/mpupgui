import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup/utility/mpup_scroller.dart';
import 'package:mpupgui/widgets/mpup_scaffold.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenuInstalls extends StatefulWidget {
  const ModManagerMenuInstalls({super.key});

  @override
  State<ModManagerMenuInstalls> createState() => _ModManagerMenuInstallsState();
}

class _ModManagerMenuInstallsState extends State<ModManagerMenuInstalls> {

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return Scaffold(
      body: MagickaPupBackground(
        level: 0,
        child: Column(
          children: [
            IntrinsicHeight(
              child: MagickaPupContainer(
                height: 60,
                text: "Actions",
                level: 2,
                child: Row(
                  children: getActionButtonWidgets(),
                ),
              ),
            ),
            Expanded(
              child: MagickaPupContainer(
                text: "Installs",
                level: 2,
                child: MagickaPupScroller(
                  controller: controller,
                  children: getInstallsWidgets(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getActionButtonWidget(String text, Function? action) {
    return Expanded(
      child: MagickaPupButton(
        onPressed: (){
          if(action != null) {
            action();
          }
        },
        child: MagickaPupText(
          text: text,
        ),
      ),
    );
  }

  List<Widget> getActionButtonWidgets() {
    return [
      getActionButtonWidget("Add new Install", null),
      getActionButtonWidget("Open Installs Directory", null),
      getActionButtonWidget("Refresh", null),
    ];
  }

  List<Widget> getInstallsWidgets() {
    List<Widget> ans = [];

    return ans;
  }
}
