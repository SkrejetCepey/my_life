import 'package:hive/hive.dart';
import 'package:my_life/db/repository_interface.dart';

mixin HiveDBImplementationMixin<T extends HiveObject> implements Repository<T> {

  Box<T> _db;
  String _databaseName;

  set databaseName(String s) => _databaseName = s;

  Future<Box<T>> get database async {

    if (_db == null) {
      _db = await _init();
    }
    return Future.value(_db);

  }

  Future<Box<T>> _init() async {
    return await Hive.openBox<T>(_databaseName)..compact();
  }

  @override
  Future<void> create(T entry) async {
    return await database..add(entry);
  }

  @override
  Future<void> update(T entry) async {
    return await entry.save();
  }

  @override
  Future<List<T>> getAll() async {
    return (await database).values.toList();
  }

  @override
  Future<void> delete(T entry) async {
    return await entry.delete();
  }
}