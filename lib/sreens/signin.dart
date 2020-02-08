import 'package:flutter/material.dart';
import 'package:todo/sreens/dbHelper.dart';
import 'user.dart';
import 'home.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  String pseudo;

  String password;

  String password1;



  final db = DbHelper();
  List<User> users= [];


  final _final = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //future =  DatabaseHelper.query();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Signin"),
      ),
      body: Form(
        key: _final,
        child: ListView (
          children: <Widget>[
            Image.asset("asset/signin.png"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Pseudo",
                icon: Icon(Icons.account_circle),
              ),
              validator: (value){
                return value.length<5? "trop court ": null;
              },
              onChanged: (value)
              {
                pseudo = value.toString().trim();
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                icon: Icon(Icons.vpn_key)
              ),
              validator: (value){
                // ? est une boucle if else
                return value.length<6 ?"password too short":null;           
              },
              onChanged: (value)
              {
                password = value.toString().trim();
                
              },
              obscureText: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password Comfirmation",
                icon: Icon(Icons.vpn_key),
              ),
              validator: (value){
                if(value.length<6 && password!=password1)
                {
                  return "password too short and differents";
                }
                else if(value.length==0)
                {
                  return "passwords too short";
                }
                return password != password1? "passwords are difference" : null;
              },
              onChanged: (value)
              {
                password1 = value.toString().trim();
              },
              obscureText: true,
            ),
            RaisedButton(
              child: Text("Signin"),
              onPressed: () async
              {
                if(_final.currentState.validate())
                {
                  User user1 = new User(username: pseudo, password: password);
                  insert();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user1)));
                }
                
              },
              color: Colors.cyan,
            ),

          ],
        ),
      ),
    );
  }

void insert() async
{
  
  User aa= User(username: pseudo,password: password);
  await db.addTodo(aa);
  //setupList();
  /*
  User user = User(pseudo,password);
  await db.insertUser(user);
  */
 print("Data inserted successfully");
}

void setupList() async
{
  var _todos = await db.fetchAll();
  /*setState(() {
    users = _todos;
  });
  */
}


}