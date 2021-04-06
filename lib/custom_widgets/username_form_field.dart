import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/user/user.dart';

class UsernameFormField extends StatelessWidget {

  final User user;

  UsernameFormField({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (String s) => user.login = s,
      decoration: InputDecoration(
        fillColor: Colors.white60,
        hintText: 'username/login',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      ),
      validator: (String s) => s.isEmpty ? "login/username can't be empty!" : null,
    );
  }
}