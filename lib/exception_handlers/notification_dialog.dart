import 'package:flutter/material.dart';

class NotificationDialog {
  static showNotificationDialog(BuildContext context, String content) {

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget okButton = FlatButton(
      child: Text("OK!"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/main');
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}