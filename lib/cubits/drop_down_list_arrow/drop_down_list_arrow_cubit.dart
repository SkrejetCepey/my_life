import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'drop_down_list_arrow_state.dart';

class DropDownListArrowCubit extends Cubit<DropDownListArrowState> {
  DropDownListArrowCubit() : super(DropDownListArrowInitial());

  void switchDropDownListState() => emit(DropDownListArrowStateChanged());
}
