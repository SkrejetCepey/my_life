import 'package:flutter/material.dart';
import 'package:my_life/custom_widgets/email_form_field.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/custom_widgets/password_form_field.dart';
import 'package:my_life/custom_widgets/username_form_field.dart';
import 'package:my_life/models/user.dart';

class SignUpPage extends StatelessWidget {

  final User user = User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUpPage'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 0.0,
              height: 200.0,
            ),
            ListTile(
              title: UsernameFormField(user: user),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
              child: Row(
                children: [
                  Icon(Icons.android),
                  Expanded(
                    child: Row(
                      children: [
                        Spacer(),
                        Flexible(
                          child: SimpleAbstractFormField(model: user, iconData: Icons.android, property: 'firstName'),
                          flex: 9,
                        ),
                        Spacer(),
                        Flexible(
                          child: SimpleAbstractFormField(model: user, iconData: Icons.android, property: 'lastName'),
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
            SummaryButton(formKey: _formKey, user: user, title: 'Sign Up!'),
          ],
        ),
      ),
    );
  }
}