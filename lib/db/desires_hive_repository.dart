import 'package:my_life/db/hive_db_implementation_mixin.dart';
import 'package:my_life/models/desire/desire.dart';

class DesiresHiveRepository with HiveDBImplementationMixin<Desire> {

  DesiresHiveRepository._() {
    databaseName = 'desires';
  }
  static final DesiresHiveRepository db = DesiresHiveRepository._();

}