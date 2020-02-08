import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseHelper {
  Database _db;

  static final table = 'todo';

  Future<Database> get db async{
    if(_db != null)
    {
      return _db;
    }
    else
    {
      _db = await init();
    }

    return _db;
  }

  init() async
  {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentDirectory.path, 'database.db');
    var database = openDatabase(dbPath,version: 1, onCreate: _oncreate);
    return database;
  }

  void _oncreate(Database db, int version)
  {
    db.execute('''
    CREATE TABLE $table(
      username TEXT PRIMARY KEY,
      password TEXT)
    ''');
    print("Database was created");
  }
//la Db retourne des donnees de type Future
  Future<int> insertUser(User user) async
  {
    var client = await db;
    var i = await client.insert('$table', user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return i;
  }

}