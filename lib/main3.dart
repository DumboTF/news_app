import 'dart:convert';

import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(new MaterialApp(
    title: 'navigate demo',
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First page'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('Go to 2nd page'),
            onPressed: () {
              print('This is first page');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondScreen()));
            }),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('${this} hashCode=${this.hashCode}');
    var user = User("a", "b");
    var us = user.toString();
    var uss = user.toJson().toString();
    Map uMap = json.decode(us);
    var u = User.fromJson(uMap);
    print(u);
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("Go back"),
            onPressed: () {
              print('This is 2nd page');
              Navigator.pop(context);
            }),
      ),
    );
  }
}
