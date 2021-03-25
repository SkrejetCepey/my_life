import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/icon_data_structure/icon_data_structure.dart';

part 'icon_picker_state.dart';

class IconPickerCubit extends Cubit<IconPickerState> {

  Desire model;

  IconPickerCubit({this.model}) : super(IconPickerInitial());

  void addIcon(IconData icon) {
    this.model.iconDataStructure = IconDataStructure(icon.codePoint, icon.fontFamily);
    emit(IconPickerAddedIcon());
  }

}
