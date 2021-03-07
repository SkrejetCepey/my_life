import 'package:flutter/material.dart';

class AlertException {

  static showAlertDialog(BuildContext context, String errMessage) async {

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Oups!"),
      content: Text(errMessage),
      actions: [
        okButton,
      ],
    );

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}