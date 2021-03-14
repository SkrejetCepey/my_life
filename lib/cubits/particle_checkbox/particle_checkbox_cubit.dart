import 'package:bloc/bloc.dart';

class ParticleCheckboxCubit extends Cubit<bool> {
  ParticleCheckboxCubit() : super(false);

  void switchParticleCheckBoxState() => emit(!state);
}