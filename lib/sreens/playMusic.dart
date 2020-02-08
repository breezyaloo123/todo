import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import '../sreens/artist.dart';

class PlayMusic extends StatefulWidget {

  FetchArtist music;
  

  PlayMusic(this.music);
 
  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  double counter = 0;
  AudioPlayer audioPlayer = new AudioPlayer();
  Timer t;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    if(this.mounted)
        {
          //const second =const Duration(seconds: 1);
          Timer.periodic(Duration(seconds: 1), (t) => setState(()
          {
            counter = counter / 30;
            
          }));
        }
        play();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   t.cancel();

  // }

  void play()async
  {
    await audioPlayer.play(widget.music.preview);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.music.title_short),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Stack permet de superposer les elements entre eux
          Stack(
            
            children: <Widget>[
              Center(
                
                child: Container(
                  
                  height: 250,
                  width: 250,
                  child: CircularProgressIndicator(
                    value: counter,
                  )),
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.music.picture),
                  ),
                ),
              ),
              
            ],
          ),
          RaisedButton(
            child: Icon(Icons.play_arrow),
            onPressed: ()
            {

              
            },
          )
        ],
      ),
    );
  }
}