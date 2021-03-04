import 'package:flutter/material.dart';

class NotificationDialog {
  static showNotificationDialog(BuildContext context, String content, Function callback) async {

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget okButton = FlatButton(
      child: Text("OK!"),
      onPressed: () {
        callback(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Attention!"),
      content: Text(content),
      actions: [
        cancelButton,
        okButton
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}