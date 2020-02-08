import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'user.dart';


class DatabaseHelper
{
  static Database _db;
  static final columnId = "id";
  static final columnU = "username";
  static final columnP= "password";
  static final dbName = "Todo";
  
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static void databaseLog(String functionName, String sql, 
  [List<Map<String, dynamic>> selectQueryResult, int insertd])
  {
    print(functionName);
    print(sql);
    if(selectQueryResult != null)
    {
      print(selectQueryResult);
    }
    else if (insertd != null)
    {
      print(insertd);
    }
  }
  
/*
  Future<Database> get() async
  {
    if(_db != null)
      return _db;
    else{
      _db = await initDB();
      return _db;
    }
  }
  */
/*
  Future<Database> initDB() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path =  join (documentsDirectory.path, "todo.db");
    return await openDatabase(path,version: 1, onCreate: _onCreate);
  }
  */

  //we create the method onCreate() with a table and fields
  /*
  Future<void> _onCreate(Database db, int version) async 
  {
    //when we create the db we create the table
    await db.execute("CREATE TABLE $dbName ("
    "$columnId INTEGER PRIMARY KEY,"
    "$columnU TEXT,"
    "$columnP TEXT"
    ")");
  }
  */

  //we create the insert method

  Future<int> insert(Map<String, dynamic> row) async
  {
    return _db.insert("Todo", row);
  }
/*
  insert(User client) async
  {
    var res = await _db.rawInsert(
      " INSERT INTO Todo  (id,username,password)"
      "  VALUES  (${client.id},${client.username},${client.password})"
    );
    return res;
  }
  */
  //we create a method the fetch all the data frolm the database

  static Future<List<User>> query() async{
    final sql = '''SELECT * FROM $dbName''';
    final data = await _db.rawQuery(sql);
    List<User> todos = List();

    for(final node in data)
    {
      final todo = User.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }


static Future<User> getTodo(int id) async
{
  final sql = '''SELECT * FROM ${DatabaseHelper.dbName}''';

  final data = await _db.rawQuery(sql);
  final todo = User.fromMap(data[0]);
  return todo;
}

static Future<void> addTodo(User userr) async
{
  final sql = '''INSERT INTO ${DatabaseHelper.dbName} 
  (
    ${DatabaseHelper.columnId},
    ${DatabaseHelper.columnU},
    ${DatabaseHelper.columnU}
  )
  VALUES
  (
    ${userr.id},
    "${userr.username}",
    "${userr.password}"
  )
  ''';
  final result = await _db.rawInsert(sql);
  DatabaseHelper.databaseLog('Add todo', sql, null, result);
}

static Future<int> todosCount() async
{
  final data = await _db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseHelper.dbName}''');

  int count = data[0].values.elementAt(0);
  return count;
}



}