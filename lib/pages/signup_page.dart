import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/custom_widgets/email_form_field.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/custom_widgets/password_form_field.dart';
import 'package:my_life/custom_widgets/username_form_field.dart';
import 'package:my_life/models/user.dart';

class SignUpPage extends StatelessWidget {

  final User user = User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ConnectionPageCubit _connectionPageCubit = ConnectionPageCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SignUpPage'),
      // ),
      body: BlocProvider(
        create: (_) => _connectionPageCubit,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                child: Image.asset('assets/logo/logo.png'),
                width: 0.0,
                height: 250.0,
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
                      title: UsernameFormField(user: user),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: SimpleAbstractFormField(model: user, property: 'firstName'),
                                  flex: 9,
                                ),
                                Spacer(),
                                Flexible(
                                  child: SimpleAbstractFormField(model: user, property: 'lastName'),
                                  flex: 9,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: EmailFormField(user: user),
                    ),
                    ListTile(
                        title: PasswordFormField(user: user)
                    ),
                  ],
                ),
              ),
              SummaryButton(formKey: _formKey, user: user, title: 'Sign Up!', connectionCubit: _connectionPageCubit),
            ],
          ),
        ),
      ),
    );
  }
}