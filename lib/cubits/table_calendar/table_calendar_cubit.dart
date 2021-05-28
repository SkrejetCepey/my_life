import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'table_calendar_state.dart';

class TableCalendarCubit extends Cubit<TableCalendarState> {
  TableCalendarCubit() : super(TableCalendarInitial());

  DateTime actualDay = DateTime.now();
  // int chooseIndexAppBar = 0;

  void selectNewDay(DateTime newDay) {
    actualDay = newDay;
    emit(TableCalendarNewDaySelected());
  }

  // void tapOnAppBar(int index) {
  //   chooseIndexAppBar = index;
  //   emit(TableCalendarNewIndexAppBarSelected());
  // }

}
