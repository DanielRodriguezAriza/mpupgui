import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

void showPopUp(BuildContext context, String title, String description, [Function? onAccept, Function? onCancel]) {
  var themeData = ThemeManager.getCurrentThemeData();
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: themeData.colors.image[1],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeData.borderRadius),
      ),
      title: MagickaPupText(
        text: title
      ),
      content: MagickaPupText(
        text: description,
      ),
      actions: <Widget>[
        SizedBox(
          height: 40,
          width: 200,
          child: MagickaPupButton(
            onPressed: (){
              Navigator.pop(context, "Cancel");
              if(onCancel != null) {
                onCancel!();
              }
            },
            child: MagickaPupText(
              text: "Cancel",
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 200,
          child: MagickaPupButton(
            onPressed: (){
              Navigator.pop(context, "Ok");
              if(onAccept != null) {
                onAccept();
              }
            },
            child: MagickaPupText(
              text: "Ok",
            ),
          ),
        ),
      ],
    ),
  );
}
