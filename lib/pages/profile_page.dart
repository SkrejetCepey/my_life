import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_life/consts/const_strings.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/handlers/notification_dialog.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PROFILE', style: TextStyle(color: Color(0xff574940))),
        actions: [
          IconButton(icon: Icon(FontAwesomeIcons.cog), onPressed: () {
            print('tapped on settings!');
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 230.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xffd5f111),
                        width: 5
                    ),
                    shape: BoxShape.circle
                ),
                margin: EdgeInsets.symmetric(vertical: 15.0),
              ),
              SizedBox(
                width: 250.0,
                child: Container(
                  height: 75.0,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle
                  ),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
              child: Text(BlocProvider.of<DesiresListCubit>(context).user.login,
                  style: TextStyle(fontSize: 25.0, color: Color(0xff574940)))),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                ExpansionTile(
                  title: Text('MY DESIRES', style: TextStyle(color: Colors.brown)),
                  children: <Widget>[
                    ListTile(
                        title: Text('temp1')
                    ),
                    ListTile(
                        title: Text('temp2')
                    ),
                    ListTile(
                        title: Text('temp3')
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('STATISTICS', style: TextStyle(color: Colors.brown)),
                  children: <Widget>[
                    ListTile(
                        title: Text('temp1')
                    ),
                    ListTile(
                        title: Text('temp2')
                    ),
                    ListTile(
                        title: Text('temp3')
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('ACHIEVEMENTS', style: TextStyle(color: Colors.brown)),
                  children: <Widget>[
                    ListTile(
                        title: Text('temp1')
                    ),
                    ListTile(
                        title: Text('temp2')
                    ),
                    ListTile(
                        title: Text('temp3')
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('Logout!'),
            onPressed: () async {
              await NotificationDialog.showNotificationDialog(context, ConstStrings.logoutWarning, _signUpLoader);
            },
          ),
        ],
      ),
    );
  }
}

void _signUpLoader(BuildContext context) async {
  BlocProvider.of<UserCubit>(context).deleteUser();

  print(await UserHiveRepository.db.getAll());
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pushNamed(context, '/home');
}