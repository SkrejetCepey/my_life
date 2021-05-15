import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'local_desire_page_state.dart';

class LocalDesirePageCubit extends Cubit<LocalDesirePageState> {

  bool goalByTask = false;
  bool retryEveryDay = false;
  bool oneTimeAnyTime = false;
  bool dateEndOrCount = false;

  bool canNotification = false;

  bool chooseDate = true;
  bool chooseCount = false;

  LocalDesirePageCubit() : super(LocalDesirePageInitial());

  void _init() {
    emit(LocalDesirePageInit());
  }

  void changeCanNotification(bool value) {
    canNotification = value;
    emit(LocalDesirePageChangeDateEndOrCount());
    _init();
  }

  void changeChooseCount() {

    if (chooseCount == false) {
      chooseCount = true;
      chooseDate = false;
      emit(LocalDesirePageChangeChooseCount());
      _init();
    }
  }

  void changeChooseDate() {

    if (chooseDate == false) {
      chooseDate = true;
      chooseCount = false;
      emit(LocalDesirePageChangeChooseDate());
      _init();
    }
  }

  void changeDateEndOrCount(bool value) {
    dateEndOrCount = value;
    emit(LocalDesirePageChangeDateEndOrCount());
    _init();
  }

  void changeGoalByTask(bool value) {
    goalByTask = value;
    emit(LocalDesirePageChangeGoalByTask());
    _init();
  }

  void changeOneTimeAnyTime(bool value) {
    oneTimeAnyTime = value;
    emit(LocalDesirePageChangeOneTimeAnyTime());
    _init();
  }

  void changeRetryEveryDay(bool value) {
    retryEveryDay = value;
    emit(LocalDesirePageChangeRetryEveryDay());
    _init();
  }
}
