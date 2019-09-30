import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(AnimApp());

class AnimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "File",
      home: StateAnim(),
    );
  }
}

class StateAnim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimState();
  }
}

class AnimState extends State<StateAnim> with SingleTickerProviderStateMixin {
  int clickCount = 0;
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animation"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            height: 300 * curve.value,
            width: 300 * curve.value,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ));
  }
}
