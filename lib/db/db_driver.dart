//deprecated

// import 'dart:io';
// import 'package:my_life/models/desire.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;
//
// class DBDriver {
//
//   //singleton
//   DBDriver._();
//   static final DBDriver db = DBDriver._();
//
//   Database _db;
//
//   Future get database async {
//     if (_db == null) {
//       _db = await _init();
//     }
//     return _db;
//   }
//
//   Future<Database> _init() async {
//     Directory docsDir = await getApplicationDocumentsDirectory();
//     String path = p.join(docsDir.path, 'desires.db');
//     Database db = await openDatabase(path, version: 1, onOpen: (db) {},
//       onCreate: (db, version) async {
//         await db.execute(
//             'CREATE TABLE IF NOT EXISTS desires ('
//                 'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
//                 'title VARCHAR(200) NOT NULL'
//                 ')'
//         );
//       },
//     );
//     return db;
//   }
//
//   Desire _noteFromMap(Map map) => Desire(
//       id: map['id'],
//       title: map['title']
//   );
//
//   Map<String, dynamic> _noteToMap(Desire desire) => <String, dynamic>{
//     'id' : desire.id,
//     'title' : desire.title
//   };
//
//   Future<void> create(Desire desire) async {
//
//     Database db = await database;
//
//     print('Insert!');
//
//     return await db.rawInsert(
//         'INSERT INTO desires (title) VALUES (?)',
//         [desire.title]
//     );
//   }
//
//   Future<Desire> get(int id) async {
//     Database db = await database;
//
//     List n = await db.rawQuery('SELECT * FROM desires WHERE id = $id');
//
//     return _noteFromMap(n.single);
//   }
//
//   Future<List<Desire>> getAll() async {
//     Database db = await database;
//
//     List desires = await db.rawQuery('SELECT * FROM desires');
//
//     return desires.isNotEmpty ? desires.map((e) => _noteFromMap(e)).toList() : [];
//   }
//
//   Future<void> update(Desire desire) async {
//     Database db = await database;
//
//     return await db.update('desires', _noteToMap(desire), where: 'id = ?', whereArgs: [desire.id]);
//   }
//
//   Future<void> delete(int id) async {
//     Database db = await database;
//
//     return await db.delete('desires', where: 'id = ?', whereArgs: [id]);
//   }
//
// }