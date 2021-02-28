import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/user.dart';

class LastNameFormField extends StatelessWidget {

  final User user;

  LastNameFormField({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.android),
        fillColor: Colors.white60,
        hintText: 'last name',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Colors.blue)
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      ),
      validator: (String s) => s.isEmpty ? "last name can't be empty!" : null,
      onSaved: (String s) => user.lastName = s,
    );
  }
}