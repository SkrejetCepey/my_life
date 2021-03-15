import 'package:bloc/bloc.dart';

class ParticleCheckboxCubit extends Cubit<bool> {
  ParticleCheckboxCubit(bool initState) : super(initState);

  void switchParticleCheckBoxState() => emit(!state);
}