import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmationDialog {
  static showConfirmationDialog(BuildContext context, String title,
      String content, Function onYesPressed) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');

      },
    );
    Widget continueButton = FlatButton(
      child: Text("go to app settings"),
      onPressed: onYesPressed,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
