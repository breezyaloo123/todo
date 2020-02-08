import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'artist.dart';
import 'package:audioplayer/audioplayer.dart';
import 'playMusic.dart';


class PlayList extends StatefulWidget {
  String name;
  PlayList({Key key, @required this.name}): super(key: key);
  @override
  _PlayListState createState() => _PlayListState(name: this.name);
}

class _PlayListState extends State<PlayList> {

  String name;
  
  _PlayListState({this.name});

  var result;
  AudioPlayer audioPlayer = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PlayList"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapchot)
        {
          if(snapchot.hasError)
          {
            return Text(snapchot.error.toString());
          }
          else if(snapchot.hasData)
          {

            List<FetchArtist> listmusic = snapchot.data;
            return listview(listmusic);
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }

        },
      ),
    );
  }

  Widget listview(List<FetchArtist> list)
  {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context,int position)
        {
          return musicView(list[position]);
        },
      );
  }


getData() async
  {
    List<FetchArtist> artistList= new List<FetchArtist>();
    //i = i +1 ;
    var url = await http.get("https://api.deezer.com/search?q=$name");
    // for (i = 0; i<=10;i++)
    // {
    //   result = json.decode(url.body)["data"][i];
    //   print(result);
    //   artist = new FetchArtist(result["artist"]["name"], result["artist"]["picture"], result["artist"]["id"].toString(),result["title"],result["preview"]);
    //   artistList.add(artist);
    // }
    result = json.decode(url.body);
    for (var music in result["data"])
    {
      artistList.add(new FetchArtist(music["artist"]["name"], music["artist"]["picture"], music["title_short"], music["title"], music["preview"],music["duration"]));
      // artist = new FetchArtist(result["artist"]["name"], result["artist"]["picture"], result["artist"]["id"].toString(),result["title"],result["preview"]);
      //artistList.add(artist);
    }

    return artistList;
    // result = json.decode(url.body)["data"][i];
    // print(result);
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

}
