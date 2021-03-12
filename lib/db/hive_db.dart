import 'package:hive/hive.dart';
import 'package:my_life/models/desire.dart';

class HiveDB {

  HiveDB._();
  static final HiveDB db = HiveDB._();

  Box<Desire> _db;

  Future<Box<Desire>> get database async {

    if (_db == null) {
      _db = await _init();
    }
    return _db;

  }

  Future<Box<Desire>> _init() async => await Hive.openBox("desires");

  Future<void> create(Desire desire) async {
    return await database..add(desire);
  }

  Future<List<Desire>> getAll() async {
    return (await database).values.toList();
  }

  Future<void> delete(Desire desire) async {
    desire.delete();
  }

  Future<void> update(Desire desire) async {
    desire.save();
  }

}