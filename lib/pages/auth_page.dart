import 'package:flutter/material.dart';
import 'package:my_life/consts/const_strings.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/custom_widgets/password_form_field.dart';
import 'package:my_life/custom_widgets/username_form_field.dart';
import 'package:my_life/exception_handlers/notification_dialog.dart';
import 'package:my_life/models/user.dart';

class AuthPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(
            width: 0.0,
            height: 250.0,
          ),
          ListTile(
            title: UsernameFormField(user: user),
          ),
          ListTile(
            title: PasswordFormField(user: user),
          ),
          SummaryButton(formKey: _formKey, user: user, title: 'Sign In!'),
          FooterContent()
        ],
      ),
    );
  }

}

class FooterContent extends StatelessWidget {
  // TODO: fix padding

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You don't have an account?", style: TextStyle(fontWeight:FontWeight.w300)),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
              child: Text('Sign up!'),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
            )
          ],
        ),
        Container(
          child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
            child: Text('Continue as guest'),
            onPressed: () {
              NotificationDialog.showNotificationDialog(context, ConstStrings.termsUsingGuest);
              // Navigator.pop(context);
              // Navigator.pushNamed(context, '/main');
            },
          ),
        )
      ],
    );
  }
}