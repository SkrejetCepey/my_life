import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/cubits/password_auth_field/password_auth_field_cubit.dart';
import 'package:my_life/models/user/user.dart';

class DoublePasswordFormField extends StatelessWidget {

  DoublePasswordFormField({Key key}) : super(key: key);

  final TextEditingController password1 = TextEditingController();
  final TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<ConnectionPageCubit>(context).user;
    return Column(
      children: [
        BlocProvider<PasswordAuthFieldCubit>(
          create: (_) => PasswordAuthFieldCubit(),
          child: BlocBuilder<PasswordAuthFieldCubit, bool>(
            builder: (BuildContext context, bool state) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  obscureText: state,
                  controller: password1,
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
                ),
              );
            },
          ),
        ),
        BlocProvider<PasswordAuthFieldCubit>(
          create: (_) => PasswordAuthFieldCubit(),
          child: BlocBuilder<PasswordAuthFieldCubit, bool>(
            builder: (BuildContext context, bool state) {
              return TextFormField(
                obscureText: state,
                controller: password2,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: state ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    onPressed: () {
                      BlocProvider.of<PasswordAuthFieldCubit>(context).switchAbilityCheckPasswordState();
                    },
                  ),
                  fillColor: Colors.white60,
                  hintText: 'repeat password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
                ),
                validator: (String s) {
                  if (s.isEmpty) {
                    return "password can't be empty!";
                  } else if (password1.text != password2.text) {
                    return "passwords isn't match!";
                  } else {
                    return null;
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}