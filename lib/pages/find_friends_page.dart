import 'package:flutter/material.dart';
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
        future: Connection.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
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