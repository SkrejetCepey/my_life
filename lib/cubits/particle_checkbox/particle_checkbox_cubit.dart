import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_life/desire_particles/particle_checkbox/particle_checkbox.dart';

part 'particle_checkbox_state.dart';

class ParticleCheckboxCubit extends Cubit<ParticleCheckboxState> {

  ParticleCheckbox checkbox;

  ParticleCheckboxCubit(this.checkbox) : super(ParticleCheckboxInitial());

  void switchParticleCheckBoxState() {
    checkbox.state = !checkbox.state;
    emit(ParticleCheckboxChanged());
  }

}