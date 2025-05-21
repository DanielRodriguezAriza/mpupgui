import 'package:flutter/material.dart';
import 'package:mpupgui/data/theme_manager.dart';
import 'package:mpupgui/widgets/mpup/io/mpup_button.dart';
import 'package:mpupgui/widgets/mpup_text.dart';

// TODO : Rework this to use the showPupUpGeneric function internally
void showPopUp({
  required BuildContext context,
  required String title,
  required String description,
  Function? onAccept,
  Function? onCancel,
})
{
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
      onCancel();
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

class PopUpAction {
  final Function? action;
  final String text;
  PopUpAction({
    required this.text,
    this.action,
  });
}

void showPopUpGeneric({
  required BuildContext context,
  required String title,
  String? description,
  Widget? body,
  List<PopUpAction>? actions,
  Function? onClose,
  bool canDismiss = true, // Determines whether the pop up can be dismissed or not (cancelled) by clicking / pressing the background.
  bool canClose = true, // Determines whether the pop up can be closed or not. If true, a close button appears at the top right.
})
{
  // Get the theme data
  var themeData = ThemeManager.getCurrentThemeData();

  // Local function to execute a given action
  void executeAction(PopUpAction action) {
    Navigator.pop(context, "Action");
    if(action.action != null) {
      action.action!();
    }
  }

  // Local function to close the popup
  void executeCancelAction() {
    Navigator.pop(context, "Cancel");
    if(onClose != null) {
      onClose();
    }
  }

  // Local function to create button widget
  Widget createButtonWidget(PopUpAction action) {
    return SizedBox(
      height: 40,
      width: 200,
      child: MagickaPupButton(
        onPressed: (){
          executeAction(action);
        },
        child: MagickaPupText(
          text: action.text,
        ),
      ),
    );
  }

  // Local function to create all button widgets
  List<Widget> createButtonWidgets() {
    List<Widget> ans = [];
    if(actions != null) {
      for (var action in actions) {
        ans.add(createButtonWidget(action));
      }
    }
    return ans;
  }

  // Local function to create top area children widgets
  List<Widget> createTopAreaWidgets() {
    final Widget topAreaButton = Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 20,
        height: 20,
        child: MagickaPupButton(
          useAutoPadding: false,
          onPressed: (){
            executeCancelAction();
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
    );
    final Widget topAreaText = Align(
      alignment: Alignment.center,
      child: MagickaPupText(
          text: title
      ),
    );
    return canClose ? [topAreaButton, topAreaText] : [Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), child: topAreaText)];
  }

  // Local function to create the widget for the content of the pop up
  Widget createContentWidget() {

    final Widget? textWidget = description == null ? null : Align(
      alignment: Alignment.center,
      child: MagickaPupText(
        text: description!,
      ),
    );
    final Widget? bodyWidget = body == null ? null : Align(
      alignment: Alignment.center,
      child: body,
    );

    List<Widget> children = [];
    if(textWidget != null) {
      var w = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: textWidget,
      );
      children.add(w);
    }
    if(bodyWidget != null) {
      children.add(bodyWidget);
    }

    final Widget ans = IntrinsicHeight(
      child: Column(
        children: children,
      ),
    );

    return ans;
  }

  // Show popup dialogue
  showDialog(
    context: context,
    barrierDismissible: canDismiss,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: themeData.colors.image[1],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeData.borderRadius),
      ),
      titlePadding: const EdgeInsets.all(5),
      title: Column(
        children: createTopAreaWidgets(),
      ),
      content: createContentWidget(),
      actionsAlignment: MainAxisAlignment.center,
      actions: createButtonWidgets(),
    ),
  );
}

void showPopUpError({
  required BuildContext context,
  required String title,
  required String description,
})
{
  showPopUpGeneric(
    context: context,
    title: title,
    description: description,
    actions: [
      PopUpAction(
        text: "Ok",
      ),
    ],
  );
}
