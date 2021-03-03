import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/summary_button_connection/summary_button_connection_cubit.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/models/user.dart';
import 'package:meta/meta.dart';

class SummaryButton extends StatelessWidget {

  final GlobalKey<FormState> _formKey;
  final User user;
  final String title;
  final SummaryButtonConnectionCubit _summaryButtonConnectionCubit = SummaryButtonConnectionCubit();

  SummaryButton({Key key, @required formKey, @required this.user, @required this.title}) : _formKey = formKey, super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _summaryButtonConnectionCubit,
      child: BlocBuilder<SummaryButtonConnectionCubit, SummaryButtonConnectionState>(
        builder: (BuildContext context, SummaryButtonConnectionState state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            child: ElevatedButton(
              child: (state is SummaryButtonTryingConnect) ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)) : Text(title),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(user.toString())));
                  _tryToConnect(context);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _tryToConnect(BuildContext context) async {
    try {
      await _summaryButtonConnectionCubit.tryConnection();
    } on Exception catch (exception) {
      AlertException.showAlertDialog(context, exception.toString());
    }
  }
}