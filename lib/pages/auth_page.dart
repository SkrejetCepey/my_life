import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/consts/const_strings.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/custom_widgets/password_form_field.dart';
import 'package:my_life/custom_widgets/username_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/user.dart';

class AuthPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionPageCubit>(
          create: (BuildContext context) => ConnectionPageCubit(),
        )
      ],
      child: BlocBuilder<ConnectionPageCubit, ConnectionPageState>(
        builder: (BuildContext context, ConnectionPageState state) {
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
                SummaryButton(formKey: _formKey, user: user, title: 'Sign In!',
                    connectionCubit: BlocProvider.of<ConnectionPageCubit>(context)),
                FooterContent(state: state)
              ],
            ),
          );
        },
      ),
    );
  }

}

class FooterContent extends StatelessWidget {
  // TODO: fix padding

  final ConnectionPageState state;

  final ButtonStyle disabledStyle = ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((_) => Colors.black26));
  final ButtonStyle enabledStyle = ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((_) => Colors.blue));

  FooterContent({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You don't have an account?", style: TextStyle(fontWeight:FontWeight.w300)),
            TextButton(
              style: (state is TryingPageConnect) ? disabledStyle : enabledStyle,
              child: Text('Sign up!'),
              onPressed: () {
                if (state is TryingPageConnect)
                  return null;
                else {
                  Navigator.pushNamed(context, '/sign_up');
                }
              },
            )
          ],
        ),
        Container(
          child: TextButton(
            style: (state is TryingPageConnect) ? disabledStyle : enabledStyle,
            child: Text('Continue as guest'),
            onPressed: () {
              if (state is TryingPageConnect)
                return null;
              else {
                NotificationDialog.showNotificationDialog(context, ConstStrings.termsUsingGuest, _mainPageLoader);
              }
            },
          ),
        )
      ],
    );
  }
}

void _mainPageLoader(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pushNamed(context, '/main');
}