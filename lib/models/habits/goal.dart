import 'package:hive/hive.dart';
import 'package:my_life/models/progress/progress.dart';

import '../abstract_model.dart';

part 'goal.g.dart';

@deprecated
@HiveType(typeId: 8)
class Goal extends HiveObject implements AbstractModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String owner;
  @HiveField(3)
  List<String> members;
  @HiveField(4)
  List<Progress> progress;

  Goal({this.id, this.title, this.owner, this.members, this.progress});

  @override
  set properties(Map<String, dynamic> s) {
    if (s['title'] != null)
      title = s['title'];
  }

  @override
  Map<String, String> get properties => {
    'title': title
  };
}