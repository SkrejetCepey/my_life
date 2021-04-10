import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';

part 'connection_page_state.dart';

class ConnectionPageCubit extends Cubit<ConnectionPageState> {

  User user = User();

  ConnectionPageCubit() : super(ConnectionPageInitial());

  Future<String> tryConnection(BuildContext context) async {
    emit(TryingPageConnect());
    try {
      return await Connection(user).tryConnect();
    } on Exception catch (exception) {
      Future.microtask(() => AlertException.showAlertDialog(context, exception.toString()));
    } finally {
      emit(ConnectionPageInitial());
    }
    return null;
  }
}
