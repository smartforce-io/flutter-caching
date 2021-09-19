import 'package:fetchingapp/model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> cacheDatabase() async {
  return openDatabase(join(await getDatabasesPath(), 'cache_database.db'),
      onCreate: (db, version) {
    return db.execute('''
    CREATE TABLE IF NOT EXISTS cache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      body TEXT
      );
      ''');
  }, version: 1);
}

//read data
Future<List<Map>> readCache() async {
  final db = await cacheDatabase();

  return db.query('cache');
}

// add entry
Future addBatchOfEntries({required List<dynamic> entries}) async {
  final db = await cacheDatabase();
  final batch = db.batch();
  for (var item in entries) {
    final entry =
        DataModel(name: item['name'], body: item['body'], email: item['email']);

    batch.insert('cache', entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  await batch.commit(noResult: true);
  print('batch insert complete');
}

Future cleanDB() async {
  if (kIsWeb) {
    return;
  }
  final db = await cacheDatabase();
  db.execute('DROP TABLE cache');
  db.execute('''
    CREATE TABLE IF NOT EXISTS cache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      body TEXT)
      ''');
}
