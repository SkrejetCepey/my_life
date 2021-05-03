import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/models/user/user.dart';

class LoginFormField extends StatelessWidget {

  LoginFormField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<ConnectionPageCubit>(context).user;
    return TextFormField(
      onSaved: (String s) => user.login = s,
      decoration: InputDecoration(
        fillColor: Colors.white60,
        hintText: 'login',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      ),
      validator: (String s) => s.isEmpty ? "login can't be empty!" : null,
    );
  }
}