import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

void showPopUp({
  required BuildContext context,
  required String title,
  required String description,
  Function? onAccept,
  Function? onCancel
}) {
  // Get the theme data
  var themeData = ThemeManager.getCurrentThemeData();

  // Local function that stores the code for the "accept" action
  void acceptAction() {
    Navigator.pop(context, "Ok");
    if(onAccept != null) {
      onAccept();
    }
  }

  // Local function that stores the code for the "cancel" action
  void cancelAction() {
    Navigator.pop(context, "Cancel");
    if(onCancel != null) {
      onCancel!();
    }
  }

  // Show popup dialogue
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: themeData.colors.image[1],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeData.borderRadius),
      ),
      titlePadding: const EdgeInsets.all(5),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 20,
              height: 20,
              child: MagickaPupButton(
                useAutoPadding: false,
                onPressed: (){
                  cancelAction();
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: MagickaPupText(
                    text: "X",
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: MagickaPupText(
                text: title
            ),
          ),
        ],
      ),
      content: IntrinsicHeight(
        child: Align(
          alignment: Alignment.center,
          child: MagickaPupText(
            text: description,
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 40,
          width: 200,
          child: MagickaPupButton(
            onPressed: (){
              cancelAction();
            },
            child: const MagickaPupText(
              text: "Cancel",
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 200,
          child: MagickaPupButton(
            onPressed: (){
              acceptAction();
            },
            child: const MagickaPupText(
              text: "Ok",
            ),
          ),
        ),
      ],
    ),
  );
}
