import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/networking/connection.dart';

part 'connection_page_state.dart';

class ConnectionPageCubit extends Cubit<ConnectionPageState> {
  ConnectionPageCubit() : super(ConnectionPageInitial());

  Future tryConnection(BuildContext context) async {
    emit(TryingPageConnect());
    try {
      await Connection().connect();
    } on Exception catch (exception) {
      Future.microtask(() => AlertException.showAlertDialog(context, exception.toString()));
    }
    emit(ConnectionPageInitial());
  }
}
