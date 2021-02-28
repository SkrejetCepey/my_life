import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/networking/connection.dart';

part 'summary_button_connection_state.dart';

class SummaryButtonConnectionCubit extends Cubit<SummaryButtonConnectionState> {
  SummaryButtonConnectionCubit() : super(SummaryButtonInitial());

  Future tryConnection() async {
    emit(SummaryButtonTryingConnect());
    await Connection().connect();
    emit(SummaryButtonFailedConnect());
    throw Exception('Connection failed!\nRequest timeout - 408');
  }
}
