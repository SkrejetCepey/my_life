import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PROFILE', style: TextStyle(color: Colors.brown)),
        actions: [
          IconButton(icon: Icon(FontAwesomeIcons.cog), onPressed: () {
            print('tapped on settings!');
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Placeholder(
            fallbackHeight: 250.0,
          ),
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
    );
  }
}