import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/connection/connection_page_cubit.dart';
import 'package:my_life/custom_widgets/summary_button.dart';

class SummarySignUpButton extends SummaryButton {

  SummarySignUpButton({Key key, @required GlobalKey<FormState> formKey, @required title}) :
        super(title: title, formKey: formKey, key: key);

  @override
  Future<void> tryToConnect(BuildContext context, ConnectionPageState state) async {
    final ConnectionPageCubit connectionCubit = BlocProvider.of<ConnectionPageCubit>(context);

    String userData = await connectionCubit.trySignUp(context);

    if (userData != null) {

      print('userData: $userData');

      Future.microtask(() =>
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully registered!'))));

      Navigator.of(context).pop();
    }
  }
}