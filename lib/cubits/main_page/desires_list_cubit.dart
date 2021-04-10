import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/db/desires_hive_repository.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/user/user.dart';

part 'desires_list_state.dart';

class DesiresListCubit extends Cubit<DesiresListState> {

  List<Desire> desireList;
  User user;
  final DesirePageCubit desiresListCubit;
  StreamSubscription desiresListCubitSubscription;

  DesiresListCubit(this.desiresListCubit) : super(DesiresListInitial()) {
    _init();
    _getUser();
    desiresListCubitSubscription = desiresListCubit.listen((DesirePageState state) {
      refresh();
    });
  }

  Future<void> _getUser() async {
    List<User> lst = await UserHiveRepository.db.getAll();
    user = lst.first;
  }

  Future<void> refresh() async {

    emit(DesiresListRefresh());
    _init();
  }

  Future<void> add(Desire desire) async {

    DesiresHiveRepository.db.create(desire);
    emit(DesiresListAddedNewItem());
    _init();
  }

  Future<void> update(Desire desire) async {

    DesiresHiveRepository.db.update(desire);
    emit(DesiresListUpdatedItem());
    _init();
  }

  Future<void> delete(Desire desire) async {

    DesiresHiveRepository.db.delete(desire);
    emit(DesiresListDeletedItem());
    _init();
  }

  Future<void> _init() async {

    desireList = await DesiresHiveRepository.db.getAll();

    if (desireList.isEmpty)
      emit(DesiresListInitialisedEmpty());
    else
      emit(DesiresListInitialised());
  }

  @override
  Future<void> close() {
    desiresListCubitSubscription.cancel();
    return super.close();
  }
}
