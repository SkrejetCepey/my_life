import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';

part 'desires_list_state.dart';

class DesiresListCubit extends Cubit<DesiresListState> {

  List<Desire> desireList;
  List<Desire> goalList;
  int chooseIndexAppBar = 0;

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
    return this.desireList.where((element) {
      return element.particleModels.where((el) {
        if (el.dateTime.day == dateTime.day &&
               el.dateTime.month == dateTime.month &&
               el.dateTime.year == dateTime.year) {
          return true;
        } else {
          return false;
        }
      }).length > 0 || (element.dateTime?.day == dateTime.day && element.dateTime?.month == dateTime.month && element.dateTime?.year == dateTime.year);
    }).toList();
    // return this.desireList.where((element) =>
    //   element.particleModels.where((el) {
    //    if (el.dateTime.day == dateTime.day &&
    //        el.dateTime.month == dateTime.month &&
    //        el.dateTime.year == dateTime.year) {
    //      return true;
    //   } else {
    //     return false;
    //   }}).length > 0).toList();
  }

  void tapOnAppBar(int index) {
    chooseIndexAppBar = index;
    // emit(DesiresSelectedNewBarIndex());
    refresh();
  }

  Future<void> _getUserAndInit() async {

    User user = (await UserHiveRepository.db.getAll()).last;
    this.user = user;
    await _init();
  }

  Future<void> updateUser(User user) async {
    this.user = user;
    emit(DesiresListUpdateUser());
    await _init();
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

  Future<void> addGoal(Desire goal) async {

    user.goalsList = List<Desire>.from(user.goalsList)..add(goal);
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

  Future<void> updateGoal(Desire desire) async {

    user.goalsList = List<Desire>.from(user.goalsList)
      ..insert(user.goalsList.indexOf(desire), desire)
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

  Future<void> deleteGoal(Desire desire) async {

    user.goalsList = List<Desire>.from(user.goalsList)..remove(desire);

    UserHiveRepository.db.update(this.user);

    emit(DesiresListDeletedItem());
    _init();

  }

  Future<void> _init() async {

    desireList = user.desiresList;
    goalList = user.goalsList;
    // BlocProvider.of<TableCalendarCubit>(context).chooseIndexAppBar;

    if (desireList.isEmpty && chooseIndexAppBar == 0)
      emit(DesiresListInitialisedEmpty());
    else if (desireList.isNotEmpty && chooseIndexAppBar == 0)
      emit(DesiresListInitialised());
    else if (goalList.isEmpty && chooseIndexAppBar == 1) {
      try {
        if ((await Connection.getAllUserGoals(user)).length > 0) {
          emit(DesiresListInitialised());
        } else {
          emit(DesiresListInitialisedEmpty());
        }
      } on MLNetworkError catch(e) {
        emit(DesiresListRefreshTokens());
      }

    }
    else if (goalList.isNotEmpty && chooseIndexAppBar == 1) {
      // BlocProvider.of<UserCubit>(context).updateTokens();
      emit(GoalsListInitialised());
    }

  }

  @override
  Future<void> close() {
    _desiresListCubitSubscription.cancel();
    return super.close();
  }
}
