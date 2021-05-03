import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';
import 'package:my_life/pages/other_user_page.dart';

class FindFriendPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindFriendPage'),
      ),
      body: FutureBuilder(
        future: Connection.getAllUsers(BlocProvider.of<DesiresListCubit>(context).user, context),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {

          if (snapshot.hasError) {
            Future.microtask(() => AlertException.showAlertDialog(context, snapshot.error.toString())).then((value)
            {
              Future.wait([BlocProvider.of<UserCubit>(context).deleteUser()]).then((value) => Navigator.of(context).pop());
            });
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text('${snapshot.data[index].id}'),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text('${snapshot.data[index].username}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            OtherUserPage(snapshot.data[index])));
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}