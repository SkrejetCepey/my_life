import 'package:hive/hive.dart';
import 'package:my_life/db/db_interface.dart';
import 'package:my_life/models/desire/desire.dart';


class HiveDB implements Database<Desire> {

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

  @override
  Future<void> create(Desire desire) async {
    return await database..add(desire);
  }

  @override
  Future<void> update(Desire desire) async {
    return await desire.save();
  }

  @override
  Future<List<Desire>> getAll() async {
    return (await database).values.toList();
  }

  @override
  Future<void> delete(Desire desire) async {
    return await desire.delete();
  }

}