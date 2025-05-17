import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

class ModManagerMenuProfileEntry extends StatefulWidget {

  final Function? onApply;
  final Function? onCancel;

  const ModManagerMenuProfileEntry({
    super.key,
    this.onApply,
    this.onCancel,
  });

  @override
  State<ModManagerMenuProfileEntry> createState() => _ModManagerMenuProfileEntryState();
}

class _ModManagerMenuProfileEntryState extends State<ModManagerMenuProfileEntry> {
  @override
  Widget build(BuildContext context) {
    return MagickaPupBackground(
      child: Column(
        children: [
          IntrinsicHeight(
            child: MagickaPupContainer(
              height: 60,
              text: "Actions",
              level: 2,
              child: Row(
                children: [
                  Expanded(
                    child: MagickaPupButton(
                      onPressed: (){
                        if(widget.onApply != null) {
                          widget.onApply!();
                        }
                      },
                      child: MagickaPupText(
                        text: "Apply Changes"
                      ),
                    ),
                  ),
                  Expanded(
                    child: MagickaPupButton(
                      onPressed: (){
                        if(widget.onCancel != null) {
                          widget.onCancel!();
                        }
                      },
                      child: MagickaPupText(
                        text: "Cancel",
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MagickaPupContainer(
              text: "Profile",
              level: 2,
              child: MagickaPupText(
                text: "hi",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
