import 'package:flutter/material.dart';

class NotificationDialog {
  static showNotificationDialog(BuildContext context, String content, Function callback) async {

    Widget cancelButton = TextButton(
      child: Text("Отмена"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget okButton = TextButton(
      child: Text("ОК!"),
      onPressed: () async {
        await callback(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Внимание!"),
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