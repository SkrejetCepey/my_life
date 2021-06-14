import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/consts/const_strings.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/handlers/logout_dialog.dart';
import 'package:my_life/pages/profile_page.dart';
import 'package:my_life/pages/statistic_page.dart';
import 'my_friends_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: InkResponse(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffd5f111), width: 5),
                        shape: BoxShape.circle),
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                          BlocProvider.of<DesiresListCubit>(context).user.login,
                          style: TextStyle(
                              fontSize: 25.0, color: Color(0xff574940)))),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xffa0b50e),
            ),
          ),
          ListTile(title: Text('Мои привычки'), enabled: false),
          ListTile(title: Text('Общие привычки'), enabled: false),
          ListTile(
            onTap: () {
              if (BlocProvider.of<UserCubit>(context).user.role == "Guest") {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Недоступно в гость-моде!")));
                return null;
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => StatisticPage()));
              }
            },
            title: Text('Статистика'),
          ),
          ListTile(
            title: Text('Друзья'),
            onTap: () {
              if (BlocProvider.of<UserCubit>(context).user.role == "Guest") {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Недоступно в гость-моде!")));
                return null;
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyFriendsPage()));
              }
            },
          ),
          ListTile(title: Text('Достижения'), enabled: false),
          ListTile(title: Text('Настройки'), enabled: false),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Выйти'),
            onTap: () async {
              await LogoutDialog.showLogoutDialog(
                  context, ConstStrings.logoutWarning, _signUpLoader);
            },
          )
        ],
      ),
    );
  }
}

void _signUpLoader(BuildContext context) async {
  // BlocProvider.of<UserCubit>(context).deleteUser();

  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pushNamed(context, '/home');
}
