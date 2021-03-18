import 'package:bloc/bloc.dart';

class DropDownListArrowCubit extends Cubit<bool> {
  DropDownListArrowCubit() : super(false);

  void switchDropDownListState() => emit(!state);
}
