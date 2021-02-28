import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/observer/global_observer.dart';
import 'package:my_life/pages/auth_page.dart';
import 'package:my_life/pages/main_page.dart';
import 'package:my_life/pages/signup_page.dart';

void main() {
  Bloc.observer = GlobalObserver();
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/sign_up': (BuildContext context) => SignUpPage(),
        '/main': (BuildContext context) => MainPage()
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('My life prototype'),
        ),
        body: AuthPage()
      ),
    );
  }

}