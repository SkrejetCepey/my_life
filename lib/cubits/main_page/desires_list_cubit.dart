import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/user/user.dart';

part 'desires_list_state.dart';

class DesiresListCubit extends Cubit<DesiresListState> {

  List<Desire> desireList;
  User user;

  final DesirePageCubit desiresListCubit;
  StreamSubscription _desiresListCubitSubscription;

  DesiresListCubit(this.desiresListCubit) : super(DesiresListInitial()) {
    _getUserAndInit();

    _desiresListCubitSubscription = desiresListCubit.listen((DesirePageState state) {
      if (desiresListCubit.desire.isInBox)
        update(desiresListCubit.desire);
    });
  }

  List<Desire> actualDesires(DateTime dateTime) {

    return this.desireList.where((element) =>
      element.particleModels.where((element) {
       if (element.dateTime.day == dateTime.day &&
       element.dateTime.month == dateTime.month &&
       element.dateTime.year == dateTime.year) {
         return true;
      } else {
        return false;
      }}).length > 0).toList();
  }

  Future<void> _getUserAndInit() async {

    User user = (await UserHiveRepository.db.getAll()).last;
    this.user = user;
    await _init();
  }

  void updateUser(User user) {
    this.user = user;
    emit(DesiresListUpdateUser());
    _init();
  }

  Future<void> deleteCurrentUser() async {
    await UserHiveRepository.db.delete(this.user);
    this.user = null;
    emit(DesiresListDeleteCurrentUser());
    _init();
  }

  Future<void> refresh() async {

    emit(DesiresListRefresh());
    _init();
  }

  Future<void> add(Desire desire) async {

    user.desiresList = List<Desire>.from(user.desiresList)..add(desire);
    UserHiveRepository.db.update(this.user);
    emit(DesiresListAddedNewItem());
    _init();

  }

  Future<void> update(Desire desire) async {

    user.desiresList = List<Desire>.from(user.desiresList)
      ..insert(user.desiresList.indexOf(desire), desire)
      ..remove(desire);

    UserHiveRepository.db.update(this.user);

    emit(DesiresListUpdatedItem());
    _init();

  }

  Future<void> delete(Desire desire) async {

    user.desiresList = List<Desire>.from(user.desiresList)..remove(desire);

    UserHiveRepository.db.update(this.user);

    emit(DesiresListDeletedItem());
    _init();

  }

  Future<void> _init() async {

    desireList = user.desiresList;

    if (desireList.isEmpty)
      emit(DesiresListInitialisedEmpty());
    else
      emit(DesiresListInitialised());
  }

  @override
  Future<void> close() {
    _desiresListCubitSubscription.cancel();
    return super.close();
  }
}
