import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {

  final TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.topCenter,
            child: Text('Hello,\nguest!', style: _textStyle),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.topCenter,
            child: Text('You look like newbie here!', style: _textStyle),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.topCenter,
            child: Text('Start by adding a new target at the bottom right!', style: _textStyle),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_desire');
        },
      ),
    );
  }
}