import 'package:flutter/material.dart';
import 'package:my_life/models/user/user.dart';

class OtherUserPage extends StatelessWidget {

  final User user;

  OtherUserPage(this.user);

  @override
  Widget build(BuildContext context) {

    List<String> listProperties = user.getNotNullProperties().values.toList();
    List<String> listKeys = user.getNotNullProperties().keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('OtherUserPage'),
      ),
      body:  ListView.builder(
        itemCount: user.getNotNullProperties().length,
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
      ),
    );
  }
}