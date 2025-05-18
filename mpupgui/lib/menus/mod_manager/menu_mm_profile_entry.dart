import 'package:flutter/material.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_background.dart';
import 'package:mpupgui/widgets/mpup/container/mpup_container.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';
import 'package:mpupgui/widgets/mpup_text_field.dart';

class ModManagerMenuProfileEntry extends StatefulWidget {

  final String path;
  final bool isNew;
  final Function? onApply;
  final Function? onCancel;

  const ModManagerMenuProfileEntry({
    super.key,
    required this.path,
    required this.isNew,
    this.onApply,
    this.onCancel,
  });

  @override
  State<ModManagerMenuProfileEntry> createState() => _ModManagerMenuProfileEntryState();
}

class _ModManagerMenuProfileEntryState extends State<ModManagerMenuProfileEntry> {
  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget getWidget(BuildContext context) {
    return MagickaPupBackground(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: MagickaPupText(
              text: widget.isNew ? "Create Profile" : "Edit Profile",
              fontSize: 30,
              isBold: true,
            ),
          ),
          Expanded(
            child: MagickaPupContainer(
              // text: "Profile Configuration",
              level: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: MagickaPupText(
                              text: "Profile Name",
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: MagickaPupTextField(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: MagickaPupContainer(
                            text: "Base",
                            // TODO : Implement
                          ),
                        ),
                        Expanded(
                          child: MagickaPupContainer(
                            text: "Mods",
                            // TODO : Implement
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          IntrinsicHeight(
            child: MagickaPupContainer(
              height: 60,
              // text: "Actions",
              level: 2,
              child: Row(
                children: [
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
                  ), // Cancel button
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
                  ), // Accept button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
