import '../desire_particle_model.dart';

class Progress {

  String owner;
  DateTime _date;
  List<DesireParticleModel> desireParticleModels;

  set date(DateTime v) {
    _date = v;
    this.desireParticleModels = desireParticleModels.map((e) {
      e.dateTime = _date;
      return e;
    }).toList();
  }
  DateTime get date => _date;

  Progress({this.owner, this.desireParticleModels});
}