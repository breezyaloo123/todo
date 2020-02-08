import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/sreens/playlist.dart';
import 'package:todo/sreens/user.dart';
import 'signin.dart';
import 'dbHelper.dart';
import '../sreens/playlist.dart';
import 'home.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<User> users= [];
  bool userVal;

  String username;

  String password;

  String value0;
  String valu1;
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("asset/login.png"),
          TextField(
            decoration: InputDecoration(
              hintText: "Username",
              icon: Icon(Icons.account_circle)
            ),
            onChanged: (value){
              username = value.toString().trim();
            },
          ),
          TextField(
            //keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Password",
              icon: Icon(Icons.vpn_key)
            ),
            onChanged: (value){
              password = value.toString().trim();
            },
            obscureText: true,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: ()
            {
              fetchData();
            },
            color: Colors.green,
          ),
          RaisedButton(
            child: Text("Signin"),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder:(context) => Signin()));
            },
            color: Colors.blue,
          )

        ],
      ),
    );
  }

  void fetchData() async
  {
    //Database db = await DbHelper.instance.db;
    var db = DbHelper();
    
    //var todos = await db.query(DbHelper.table);
    userVal = await db.fetchUser(username, password);
  /*
    todos.forEach((row) => 
    print(row.values.elementAt(1)+" "+row.values.elementAt(2))
    );
    */
    User user = User(username: username,password: password);

    if(userVal == true)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user)));
    }
    else
    {
      _snackbar();
    }

    

    /*
    for(var row in todos)
    {
      print(row.values.elementAt(1)+" "+row.values.elementAt(2));
      /*((row.values.elementAt(1) == username) && (row.values.elementAt(2) == password))? Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user))):
      null;*/
      
      if((row.values.elementAt(1) == username) && (row.values.elementAt(2) == password))
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user)));
      }
      else
      {
        _snackbar();
      }
      /*
      else
      {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
        
      }
      */
    }
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
    //print(todos);
  /*
    setState(() {
      users = todos;
      users.forEach((pp) => print(pp)); 
    });
    */
    */
    
  }

  _snackbar()
  {
    final snackbar = new SnackBar(
      content: Text("PLEASE CREATE AN ACCOUNT BEFORE CONNECTING"),
    );
    _scaffold.currentState.showSnackBar(snackbar);
}
}