import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';

part 'desire_page_state.dart';

class DesirePageCubit extends Cubit<DesirePageState> {

  Desire desire;

  DesirePageCubit() : super(DesirePageInitial());

  Future<void> addDesire(Desire desire) async {
    this.desire = desire;
  }

  Future<void> add(DesireParticleModel val) async {
    emit(DesirePageAddedNewParticleDesire());
    desire.particleModels = List.from(desire.particleModels)..add(val);
    _init();
  }

  Future<void> update(DesireParticleModel val) async {
    emit(DesirePageUpdateParticlesDesire());
    //TODO fix this
    desire.particleModels = List.from(desire.particleModels)..insert(desire.particleModels.indexOf(val), val);
    desire.particleModels..removeLast();
    _init();
  }

  Future<void> delete(DesireParticleModel val) async {
    emit(DesirePageDeleteParticlesDesire());
    desire.particleModels = List.from(desire.particleModels)..remove(val);
    _init();
  }

  Future<void> _init() async {
    if (desire.particleModels.isEmpty)
      emit(DesirePageParticlesDesireEmpty());
    else
      emit(DesirePageListParticlesDesire());
  }
}

