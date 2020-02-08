
import 'package:flutter/material.dart';
import 'package:todo/sreens/artistPage.dart';
import 'package:todo/sreens/playlist.dart';
import 'user.dart';
import 'artist.dart';

class Home extends StatefulWidget {
  User user;
  //constructor
  Home(this.user);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  final _name = GlobalKey<FormState>();
  var result;
  FetchArtist artist;
  final List<FetchArtist> artistList = new List<FetchArtist>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text(widget.user.username),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _snackbar,
          )
        ],
      ),
      body: ListView (
        children: <Widget>[
          Image.asset("asset/logo.jpg"),
          Form(
              key: _name,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Taper le nom de l'artiste",
                  suffixIcon:IconButton(
                    icon: Icon(Icons.search),
                    onPressed: ()
                    {
                      if(_name.currentState.validate())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayList(name: name)));
                      }
                    },
                  ) 
                ),
                onChanged: (value)
                {
                  name = value;
                },
                validator: (value)
                {
                  return value.length<2? "Nom trop court":null;
                },
              ),
            ),
        ],
      ),

    );
  }

  _snackbar()
  {
    final snackbar = new SnackBar(
      content: Text("Welcome  " + widget.user.username),
    );
    _scaffold.currentState.showSnackBar(snackbar);
  }
}