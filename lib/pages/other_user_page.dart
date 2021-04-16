import 'package:flutter/material.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';

class OtherUserPage extends StatelessWidget {

  final User user;

  OtherUserPage(this.user);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('OtherUserPage'),
      ),
      body: FutureBuilder(
        future: Connection.getUser(user.id),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {

            List<String> listProperties = snapshot.data.getNotNullProperties().values.toList();
            List<String> listKeys = snapshot.data.getNotNullProperties().keys.toList();

            return ListView.builder(
              itemCount: snapshot.data.getNotNullProperties().length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('${listKeys[index]}'),
                      SizedBox(width: 25.0),
                      Text('${listProperties[index]}')
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}