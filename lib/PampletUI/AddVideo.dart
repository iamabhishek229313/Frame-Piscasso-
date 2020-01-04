import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../PlayerUI/FPlayer.dart';

class AddVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Frame Picasso'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              print("Menu");
            },
          ),
        ],
      ),
      body: new SafeArea(
        child: new Align(
          alignment: Alignment.center,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.black)),
                    color: Colors.redAccent,
                    splashColor: Colors.red,
                    child: new Icon(
                      Icons.add,
                      size: 90.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _fileCrawler(context);
                    }),
              ]),
        ),
      ),
    );
  }

  _fileCrawler(BuildContext context) async {
    print("object");
    try {
      File file = await FilePicker.getFile(type: FileType.VIDEO).then((file) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FPlayer(file)),
        ); // getting the file path from the device .
      });
    } catch (ex) {
      print(ex);
    }
  }
}
