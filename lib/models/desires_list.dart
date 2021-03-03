import 'package:my_life/db/db_driver.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire.dart';

class DesiresList extends AbstractModel {

  Future<List> get desiresList {
    return DBDriver.db.getAll();
  }

  Future<void> add(Desire desire) async {
    await DBDriver.db.create(desire);
  }

  Future<void> update(Desire desire) async {
    await DBDriver.db.update(desire);
  }

  Future<void> delete(Desire desire) async {
    await DBDriver.db.delete(desire.id);
  }

}