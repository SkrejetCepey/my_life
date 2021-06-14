import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';

part 'appbar_builder_state.dart';

class AppBarBuilderCubit extends Cubit<AppBarBuilderState> {

  DateTime _pickedDateTime = DateTime.now();
  DateTime _today = DateTime.parse(DateTime.now().toString().substring(0, 10));

  AppBarBuilderCubit() : super(AppbarBuilderInitial());

  Widget getCurrentDateWidget(BuildContext context) {
    if (_pickedDateTime.toString().substring(0, 10) == _today.toString().substring(0, 10)) {
      return Text('Сегодня',
          style: TextStyle(
              color: Colors.brown[600]
          ));
    } else {
      return Row(
        children: [
          Text('${DateFormat('d EEE', 'ru_RU').format(_pickedDateTime)}',
            style: TextStyle(
                color: Colors.brown[600]
            )),
          TextButton(
            onPressed: () {
              _pickedDateTime = DateTime.now();
              BlocProvider.of<TableCalendarCubit>(context).selectNewDay(DateTime.now());
            },
              child: Text('Сегодня',
              style: TextStyle(
                color: Colors.brown[600]
              ))
          )
        ],
      );
    }
  }

  set dateTime(DateTime dateTime) {

    _pickedDateTime = dateTime;

    emit(AppbarBuilderSetDateTime());
    return null;
  }

  DateTime get dateTime => _pickedDateTime;

}
