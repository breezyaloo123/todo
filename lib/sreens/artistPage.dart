import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/sreens/playMusic.dart';
import 'artist.dart';
import 'package:audioplayer/audioplayer.dart';

class ArtistPage extends StatefulWidget {
  String name;
  ArtistPage({Key key, @required this.name}) : super(key: key);
  @override
  _ArtistPageState createState() => _ArtistPageState(name: this.name);
}

class _ArtistPageState extends State<ArtistPage> {

  String name;
  _ArtistPageState({this.name});

  List<FetchArtist> artistList= new List<FetchArtist>();
  var result;
  FetchArtist artist;
  int i;
  //we create an instance of AudioPlayer
  AudioPlayer audioPlayer = new AudioPlayer();
  //we create a parameter which take the value AudioPlayerState.STOPPED
  AudioPlayerState playerState = AudioPlayerState.STOPPED;
  //we create a getter which change the value of playerState
  //get isPlaying => playerState = AudioPlayerState.PLAYING;

  bool get isPlaying
  {
    playerState = AudioPlayerState.PLAYING;
    return true;
  }

    List<FetchArtist> listmusic ;



  bool isplay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "+name),
        actions: <Widget>[
          GestureDetector(
            onTap: ()
            {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Container(
                    height: 300,
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: (){},
                        )
                      ),
                      onChanged: (value){

                      },
                    ),
                  ),
                  title: Text("Please enter the name of your artist"),
                  actions: <Widget>[
                    RaisedButton(
                      child: new Text(""),
                      onPressed: ()
                      {

                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: listview(),
    );
  }



getData() async
  {

    var url = await http.get("https://api.deezer.com/search?q=$name");
    result = json.decode(url.body);
    for (var music in result["data"])
    {
      artistList.add(new FetchArtist(music["artist"]["name"], music["artist"]["picture"], music["artist"]["id"].toString(), music["title"], music["preview"],music["duration"]));

    }

    return artistList;

  }

  Widget musicView(FetchArtist music)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayMusic(music)));
      },
      child: ListTile(
        leading: Image.network(music.picture),
        title: Text(music.name),
        subtitle: Text(music.title_short),
        trailing: IconButton(icon: Icon(Icons.play_arrow),
        onPressed: () async
        {
          await audioPlayer.play(music.preview);
        },),
      ),
    );
  }


  Widget listviewBuilder(List<FetchArtist> list)
  {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position)
      {
        return musicView(list[position]);
      },
    );
  }

  Widget showData(int position)
  {
    return ListTile(
      leading:CircleAvatar(backgroundImage: NetworkImage(artistList[position].picture),),
      title: Text(artistList[position].name),
      subtitle: Text(artistList[position].title_short),
      trailing: RaisedButton.icon(
      icon: Icon(!isplay?Icons.pause:Icons.play_arrow),
      onPressed: () 
      {
        play(artistList[position].preview);
        // if(isPlaying == false)
        // {
        //   pause();
        //   Icon(Icons.pause);
        // }
        // else
        // {
        //   play(artistList[position].preview);
        //   Icon(Icons.play_arrow);
        // }
      }, 
      label: Text("play"),
    )
      );
  }

  Future play(String url) async
  {
    await audioPlayer.play(url);
    setState(() {
      playerState = AudioPlayerState.PLAYING;
    });
  }

  Future pause() async
  {
    await audioPlayer.pause();
    setState(() => playerState = AudioPlayerState.PAUSED );
  }

Widget listview()
  {
    return !isplay?FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapchot)
                  {
                    if(snapchot.hasData)
                    {
                      listmusic = snapchot.data;
                      return listviewBuilder(listmusic);
                    }
                    else if(snapchot.hasError)
                    {
                      return Text(snapchot.error.toString());
                    }
                    else
                    {
                      return CircularProgressIndicator(backgroundColor: Colors.green,);
                    }
                  },
                ):listviewBuilder(listmusic);
  }
}