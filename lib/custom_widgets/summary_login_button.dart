import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/custom_widgets/summary_button.dart';

class SummaryLoginButton extends SummaryButton {

  SummaryLoginButton({Key key, @required GlobalKey<FormState> formKey, @required title}) :
        super(title: title, formKey: formKey, key: key);

  @override
  Future<void> tryToConnect(BuildContext context, ConnectionPageState state) async {
    final ConnectionPageCubit connectionCubit = BlocProvider.of<ConnectionPageCubit>(context);

    String userData = await connectionCubit.tryLogin(context);

    if (userData != null) {
      Navigator.of(context).pop();

      print('userData: $userData');
      Map decodedUserData = jsonDecode(userData) as Map;

      BlocProvider.of<ConnectionPageCubit>(context).user.accessToken = decodedUserData['accessToken'];
      BlocProvider.of<ConnectionPageCubit>(context).user.refreshToken = decodedUserData['refreshToken'];

      BlocProvider.of<UserCubit>(context).addUser(BlocProvider.of<ConnectionPageCubit>(context).user);

      Navigator.pushNamed(context, '/home');
    }
  }
}