import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(FileApp());

class FileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "File",
      home: StateFile(),
    );
  }
}

class StateFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FileState();
  }
}

class FileState extends State<StateFile> {
  int clickCount = 0;

  //对2取模
  bool _isZero(int num) {
    return num % 2 == 0;
  }

  //
  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File("$dir/counter.txt");
  }

  //
  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on Exception {
      return 0;
    }
  }

  Future<Null> _increment() async {
    setState(() {
      clickCount++;
    });
    await (await _getLocalFile()).writeAsString("$clickCount");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readCounter().then((int value) {
      setState(() {
        clickCount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _tStyle = TextStyle(
        color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold);
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              clickCount.toString(),
              style: _tStyle,
            ),
            IconButton(
              icon: Icon(
                Icons.star,
                color: _isZero(clickCount) ? Colors.red : null,
              ),
              onPressed: () {
                _increment();
              },
            )
          ],
        ),
      ),
    );
  }
}
