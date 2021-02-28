import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/password_auth_field/password_auth_field_cubit.dart';
import 'package:my_life/models/user.dart';
import 'package:meta/meta.dart';

class PasswordFormField extends StatelessWidget {

  final User user;
  final PasswordAuthFieldCubit _passwordAuthFieldCubit = PasswordAuthFieldCubit();

  PasswordFormField({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _passwordAuthFieldCubit,
      child: BlocBuilder<PasswordAuthFieldCubit, bool>(
        builder: (BuildContext context, bool state) {
          return TextFormField(
            obscureText: state,
            onSaved: (String s) => user.password = s,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: state ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                onPressed: () {
                  return _passwordAuthFieldCubit.switchAbilityCheckPasswordState();
                },
              ),
              fillColor: Colors.white60,
              hintText: 'password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.blue)
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
            ),
            validator: (String s) => s.isEmpty ? "password can't be empty!" : null,
          );
        },
      ),
    );
  }
}