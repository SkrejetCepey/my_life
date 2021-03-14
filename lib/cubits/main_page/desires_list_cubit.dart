import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/db/hive_db.dart';
import 'package:my_life/models/desire/desire.dart';

part 'desires_list_state.dart';

class DesiresListCubit extends Cubit<DesiresListState> {

  List<Desire> desireList;

  DesiresListCubit() : super(DesiresListInitial()) {
    _init();
  }

  Future<void> refresh() async {

    emit(DesiresListRefresh());
    _init();
  }

  Future<void> add(Desire desire) async {

    HiveDB.db.create(desire);
    emit(DesiresListAddedNewItem());
    _init();
  }

  Future<void> update(Desire desire) async {

    HiveDB.db.update(desire);
    emit(DesiresListUpdatedItem());
    _init();
  }

  Future<void> delete(Desire desire) async {

    HiveDB.db.delete(desire);
    emit(DesiresListDeletedItem());
    _init();
  }

  Future<void> _init() async {

    desireList = await HiveDB.db.getAll();
    if (desireList.isEmpty)
      emit(DesiresListInitialisedEmpty());
    else
      emit(DesiresListInitialised());
  }
}
