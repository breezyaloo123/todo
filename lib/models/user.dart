class User {
  String username;
  String password;

  User(this.username,this.password);

  //we create a method called toMap() which allow us to insert data into the map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }

  User.fromMap(dynamic obj){
    username = obj["username"];
    password = obj["password"];
}
  
}