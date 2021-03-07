import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/networking/connection.dart';

part 'connection_page_state.dart';

class ConnectionPageCubit extends Cubit<ConnectionPageState> {
  ConnectionPageCubit() : super(ConnectionPageInitial());

  Future tryConnection() async {
    emit(TryingPageConnect());
    try {
      await Connection().connect();
    } on Exception catch (exception) {
      emit(FailedPageConnect(exception: exception));
    }

  }
}
