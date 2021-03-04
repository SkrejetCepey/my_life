import 'package:my_life/models/abstract_model.dart';

class Desire extends AbstractModel {

  int id;
  String title;

  Desire({this.id, this.title});

  void setTitle(String s) => title = s;

  bool isEmpty() => (id == null && title == null);

  @override
  String toString() {
    return 'Desire($id, $title)';
  }
}