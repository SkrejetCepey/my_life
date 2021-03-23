import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/models/user.dart';
import 'package:meta/meta.dart';

class SummaryButton extends StatelessWidget {

  final GlobalKey<FormState> _formKey;
  final User user;
  final String title;
  final ConnectionPageCubit connectionCubit;

  SummaryButton({Key key, @required formKey, @required this.user,
    @required this.title, @required this.connectionCubit}) : _formKey = formKey, super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionPageCubit, ConnectionPageState>(
      builder: (BuildContext context, ConnectionPageState state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
          child: ElevatedButton(
            child: (state is TryingPageConnect) ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)) : Text(title,
            style: TextStyle(color: Colors.brown)),
            onPressed: () async {
              if (!(state is TryingPageConnect)) {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(user.toString())));
                  _tryToConnect(context, state);
                  FocusScope.of(context).unfocus();
                }
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _tryToConnect(BuildContext context, ConnectionPageState state) async {
      await connectionCubit.tryConnection(context);
  }
}