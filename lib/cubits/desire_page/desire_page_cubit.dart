import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';

part 'desire_page_state.dart';

class DesirePageCubit extends Cubit<DesirePageState> {

  final Desire desire;

  DesirePageCubit({this.desire}) : super(DesirePageInitial());

  Future<void> add(DesireParticleModel val) async {
    emit(DesirePageAddedNewParticleDesire());
    desire.particleModels.add(val);
    emit(DesirePageInitial());
  }
}

