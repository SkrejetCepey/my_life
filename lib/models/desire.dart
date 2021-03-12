import 'package:hive/hive.dart';
import 'package:my_life/models/abstract_model.dart';

part 'desire.g.dart';

@HiveType(typeId: 0)
class Desire extends HiveObject with AbstractModel {

  @HiveField(0)
  String title;

  Desire({this.title});

  bool isEmpty() => (title == null);

  @override
  String toString() {
    return 'Desire($title)';
  }
}