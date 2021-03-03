import 'package:my_life/models/abstract_model.dart';

class Desire extends AbstractModel {

  int id;
  String title;

  void setTitle(String s) => title = s;

  Desire({this.id, this.title});

  @override
  String toString() {
    return 'Desire($id, $title)';
  }
}