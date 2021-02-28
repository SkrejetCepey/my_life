import 'package:bloc/bloc.dart';

class PasswordAuthFieldCubit extends Cubit<bool> {
  PasswordAuthFieldCubit() : super(true);

  void switchAbilityCheckPasswordState() => emit(!state);
}
