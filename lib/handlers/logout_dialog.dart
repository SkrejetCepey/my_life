import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/user/user.dart';

class LogoutDialog {
  static showLogoutDialog(BuildContext context, String content, Function callback) async {

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget deleteUserDataButton = TextButton(
      child: Text("Clear this user data and exit!", style: TextStyle(color: Colors.red)),
      onPressed: () async {

        await (await UserHiveRepository.db.database).compact();

        User thisUser = BlocProvider.of<UserCubit>(context).user;

        //TODO fix this next time
        for (User val in (await UserHiveRepository.db.database).values) {
          if (val.login == thisUser.login) {
            val.delete();
            break;
          }
        }

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/home");
      },
    );

    Widget okButton = TextButton(
      child: Text("OK!"),
      onPressed: () async {
        await callback(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Attention!"),
      content: Text(content),
      actions: [
        cancelButton,
        deleteUserDataButton,
        okButton
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}