import 'package:todo/sreens/databaseHelper.dart';

class User{
  final int id;
  final String username;
  final String password;
  //we create the constructer
  User({this.id,this.username,this.password});
  //we create a method called toMap() which allow us to insert data into the map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }
  //Constructor which fetch data from the DB
  User.fromMap(Map<String, dynamic> json)
    :id = json[DatabaseHelper.columnId],
      username = json[DatabaseHelper.columnU],
      password = json[DatabaseHelper.columnP];
    
}