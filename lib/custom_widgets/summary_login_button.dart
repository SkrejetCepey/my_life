import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/custom_widgets/summary_button.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/user/user.dart';

class SummaryLoginButton extends SummaryButton {

  SummaryLoginButton({Key key, @required GlobalKey<FormState> formKey, @required title}) :
        super(title: title, formKey: formKey, key: key);

  @override
  Future<void> tryToConnect(BuildContext context, ConnectionPageState state) async {

    final ConnectionPageCubit connectionCubit = BlocProvider.of<ConnectionPageCubit>(context);

    print("ConnectionCubitUser: ${connectionCubit.user}");
    String userData = await connectionCubit.tryLogin(context);

    if (userData != null) {

      print('userData: $userData');
      Map decodedUserData = jsonDecode(userData) as Map;

      BlocProvider.of<ConnectionPageCubit>(context).user.accessToken = decodedUserData['accessToken'];
      BlocProvider.of<ConnectionPageCubit>(context).user.refreshToken = decodedUserData['refreshToken'];

      bool matchFound = false;

      for (User element in (await UserHiveRepository.db.database).values) {

        if (element.login == BlocProvider.of<ConnectionPageCubit>(context).user.login) {

          element.accessToken = decodedUserData['accessToken'];
          element.refreshToken = decodedUserData['refreshToken'];

          await BlocProvider.of<UserCubit>(context).selectUser(element);
          await BlocProvider.of<DesiresListCubit>(context).updateUser(element);
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/main');
          matchFound = true;
          return;
        }

      }

      if (!matchFound) {
        print("No one users was found!");

        await BlocProvider.of<UserCubit>(context).addUser(BlocProvider.of<ConnectionPageCubit>(context).user);
        await BlocProvider.of<DesiresListCubit>(context).updateUser(BlocProvider.of<ConnectionPageCubit>(context).user);

        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/main');
      }

    }
  }
}