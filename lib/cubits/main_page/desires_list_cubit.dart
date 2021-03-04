import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/db/db_driver.dart';
import 'package:my_life/models/desire.dart';

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

  Future<void> _init() async {
    desireList = await DBDriver.db.getAll();
    if (desireList.isEmpty)
      emit(DesiresListInitialisedEmpty());
    else
      emit(DesiresListInitialised());
  }

  Future<void> add(Desire desire) async {
    await DBDriver.db.create(desire);
    emit(DesiresListAddedNewItem());
    _init();
  }

  Future<void> update(Desire desire) async {
    await DBDriver.db.update(desire);
    emit(DesiresListUpdatedItem());
    _init();
  }

  Future<void> delete(Desire desire) async {
    await DBDriver.db.delete(desire.id);
    emit(DesiresListDeletedItem());
    _init();
  }

}
