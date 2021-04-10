import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/cubits/password_auth_field/password_auth_field_cubit.dart';
import 'package:my_life/models/user/user.dart';

class PasswordFormField extends StatelessWidget {

  PasswordFormField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<ConnectionPageCubit>(context).user;
    return BlocProvider<PasswordAuthFieldCubit>(
      create: (_) => PasswordAuthFieldCubit(),
      child: BlocBuilder<PasswordAuthFieldCubit, bool>(
        builder: (BuildContext context, bool state) {
          return TextFormField(
            obscureText: state,
            onSaved: (String s) => user.password = s,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: state ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                onPressed: () {
                  BlocProvider.of<PasswordAuthFieldCubit>(context).switchAbilityCheckPasswordState();
                },
              ),
              fillColor: Colors.white60,
              hintText: 'password',
              border: OutlineInputBorder(
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