import 'package:hive/hive.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/icon_data_structure/icon_data_structure.dart';
import '../desire_particle_model.dart';

part 'desire.g.dart';

@HiveType(typeId: 0)
class Desire extends HiveObject implements AbstractModel {

  @HiveField(0)
  String title;
  @HiveField(1)
  IconDataStructure iconDataStructure;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<DesireParticleModel> particleModels = List<DesireParticleModel>.empty(growable: true);

  bool isExpanded = false;

  Desire({this.title});

  bool isEmpty() => (title == null);

  @override
  Map<String, String> get properties => {
    'title': title,
    'description': description
  };

  @override
  set properties(Map<String, String> s) {
    if (s['title'] != null)
      title = s['title'];
    if (s['description'] != null)
      description = s['description'];
  }

  double getValueCompleteParticles() {

    if (particleModels.isEmpty)
      return 0;

    return particleModels
        .where((element) => element.state != false)
        .length / particleModels.length;
  }

  @override
  String toString() {
    return 'Desire($title, ${particleModels.length})';
  }
}