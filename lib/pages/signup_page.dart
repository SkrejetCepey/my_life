import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/custom_widgets/double_password_form_field.dart';
import 'package:my_life/custom_widgets/email_form_field.dart';
import 'package:my_life/custom_widgets/summary_signup_button.dart';
import 'package:my_life/custom_widgets/login_form_field.dart';

class SignUpPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ConnectionPageCubit _connectionPageCubit = ConnectionPageCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _connectionPageCubit,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                child: Image.asset('assets/logo/logo.png'),
                width: 0.0,
                height: 200.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.grey[400]
                ),
                child: Column(
                  children: <Widget>[
                    Text('REGISTRATION', style: TextStyle(fontSize: 30.0)),
                    ListTile(
                      title: LoginFormField(),
                    ),
                    ListTile(
                      title: EmailFormField(),
                    ),
                    ListTile(
                      title: DoublePasswordFormField(),
                    ),
                  ],
                ),
              ),
              SummarySignUpButton(formKey: _formKey, title: 'Sign Up!'),
            ],
          ),
        ),
      ),
    );
  }
}