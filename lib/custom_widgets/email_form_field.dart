import 'package:flutter/material.dart';
import 'package:my_life/models/user.dart';
import 'package:meta/meta.dart';

class EmailFormField extends StatelessWidget {

  final User user;

  EmailFormField({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Colors.white60,
        hintText: 'youremailhere@gmail.com',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      ),
      validator: (String s) {
        Pattern pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(s) || s.isEmpty)
          return 'Enter a valid email address';
        else
          return null;
      },
      onSaved: (String s) => user.add('email', s),
    );
  }
}