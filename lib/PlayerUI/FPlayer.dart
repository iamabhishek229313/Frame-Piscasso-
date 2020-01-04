import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FPlayer extends StatefulWidget {
  File file;
  FPlayer(this.file);
  @override
  _FPlayerState createState() => _FPlayerState(file);
}

class _FPlayerState extends State<FPlayer> {
  File file;
  _FPlayerState(this.file);

  VideoPlayerController _controller;
  Future<void> _intializeVideoFuture;
  var _slct = 0;
  @override
  void initState() {
    _controller = VideoPlayerController.file(file);
    _intializeVideoFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var widthOfDevice = MediaQuery.of(context).size.width;
    String nameOfFile = "" ; int slash , dot ;

    for(int i = file.path.length-1 ; i >= 0 ; i--){
      if(file.path[i] == '/'){
        slash = i ;
        break ;
      }else if(file.path[i] == '.')
        dot = i ;
    }
    while(slash != dot-1){
      nameOfFile = nameOfFile + file.path[++slash] ;
    }

    print(nameOfFile);
    return new SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: new Column(children: <Widget>[
          new FutureBuilder(
              future: _intializeVideoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: new VideoPlayer(_controller),
                  );
                } else {
                  return new Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              }),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0,left: 8.0),
                child: new Text(nameOfFile,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18.0)),
              ),
            ],
          )
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.redAccent,
          fixedColor: Colors.blueGrey.shade900,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.pause),
              title: Text('Pause'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              title: Text('Play'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fullscreen),
              title: Text('Full Screen'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volume_up),
              title: Text('Volume'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Add'),
            ),
          ],
          currentIndex: _slct,
          onTap: (index) {
            if(index == 0){
              _controller.pause();
            }else if(index == 1){
              _controller.play();
            }else if(index == 2){ // Full Screen
              
            }else if(index == 3){ // Volume
                return Container(
                  width: 320.0,
                  height: 230.0,
                  color: Colors.green,
                );
              // _controller.setVolume();
            }else{
              Navigator.pop(context);
            }
            setState(() {
              _slct = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
     _controller.dispose();
  }
}

