import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:meta/meta.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/user/user.dart';

class SummaryButton extends StatelessWidget {

  final GlobalKey<FormState> _formKey;
  final String title;

  SummaryButton({Key key, @required formKey,
    @required this.title}) : _formKey = formKey, super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionPageCubit, ConnectionPageState>(
      builder: (BuildContext context, ConnectionPageState state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.brown
            ),
            child: (state is TryingPageConnect) ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)) :
            Text(title),
            onPressed: () async {
              if (!(state is TryingPageConnect)) {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
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

    final ConnectionPageCubit connectionCubit = BlocProvider.of<ConnectionPageCubit>(context);

    String userData = await connectionCubit.tryConnection(context);

    if (userData != null) {
      Navigator.of(context).pop();

      User user = BlocProvider.of<ConnectionPageCubit>(context).user;
      UserHiveRepository.db.create(user);
      Navigator.pushNamed(context, '/home');
      // Future.microtask(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(user.toString()))));
    }


  }
}