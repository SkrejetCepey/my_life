import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/consts/const_strings.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/custom_widgets/password_form_field.dart';
import 'package:my_life/custom_widgets/username_form_field.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/user/user.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AUTHORISATION', style: TextStyle(fontSize: 30.0)),
                      SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
                        title: UsernameFormField(user: user),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
                        title: PasswordFormField(user: user),
                      ),
                      SummaryButton(formKey: _formKey, user: user, title: 'Sign In!',
                          connectionCubit: BlocProvider.of<ConnectionPageCubit>(context)),
                    ],
                  ),
                ),
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
            ElevatedButton(
              style: (state is TryingPageConnect) ? disabledStyle : enabledStyle,
              child: Text('Sign up!', style: TextStyle(color: Colors.brown)),
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
            child: Text('Continue as guest', style: TextStyle(color: Colors.brown)),
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
  UserHiveRepository.db.create(User(login: 'Guest', password: ''));
}