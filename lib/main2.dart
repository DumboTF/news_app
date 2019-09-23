import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyLayoutApp());
}

class MyLayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter layout demo', home: HomeWidget());
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void toAnother() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Second"),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.00)),
                  child: Image.asset("images/lake.jpg"),
                ),
                GestureDetector(
                  child: Text(
                    "山水",
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                  onTap: () {
                    print("点击");
                  },
                  onDoubleTap: () {
                    print("双击");
                  },
                  onLongPress: () {
                    print("长按");
                  },
                  onLongPressStart: (longPressDetails) {},
                )
              ],
              alignment: Alignment.center,
            ),
            margin: const EdgeInsets.all(20.0),
            transform: Matrix4.translationValues(10, 10, 50),
          ),
        );
      }));
    }

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: GestureDetector(
              child: Text(label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: color,
                  )),
              onTap: () {
                _printText(label);
              },
            ),
          ),
        ],
      );
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          StateButton(),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
    Widget cardSection = Card(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.music_video), Text("音乐")],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.map), Text("音乐")],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.translate), Text("翻译")],
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter layout demo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.list,
              ),
              onPressed: () {
                toAnother();
              })
        ],
      ),
      body: ListView(
        children: [
          ImageTapWidget(
            child: Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          titleSection,
          buttonSection,
          textSection,
          cardSection
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _printText("float button");
        },
        tooltip: "button",
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class ImageTapWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;

  const ImageTapWidget({Key key, this.child, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageTapWidgetState();
  }
}

class ImageTapWidgetState extends State<ImageTapWidget> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    // TODO: implement build
    return GestureDetector(
//      child: AnimatedContainer(
//        duration: Duration(milliseconds: 1000),
//        child: Transform(
//            transform: Matrix4.rotationZ(0.5),
//            origin: Offset(width / 2, height / 2),
//            child: widget.child),
//        foregroundDecoration: BoxDecoration(
//            color: isDown ? Colors.white.withOpacity(0.5) : Colors.transparent),
//        padding:
//            isDown ? const EdgeInsets.all(20.0) : const EdgeInsets.all(0.0),
////        transform: Matrix4.,
//      ),
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: Duration(milliseconds: 1000),
        child: widget.child,
        foregroundDecoration: BoxDecoration(
            color: isDown ? Colors.white.withOpacity(0.5) : Colors.transparent,),
        padding:
            isDown ? const EdgeInsets.all(30.0) : const EdgeInsets.all(0.0),
        curve: Curves.linear,
      ),

      onTap: widget.onTap,
      onTapDown: (d) {
        setState(() {
          isDown = true;
        });
      },
      onTapUp: (d) {
        setState(() {
          isDown = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isDown = false;
        });
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('${this} hashCode=${this.hashCode}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("Go back"),
            onPressed: () {
              print('This is 2nd page');
              // 执行操作........
            }),
      ),
    );
  }
}

_printText(String label) {
  print(label);
}

class StateButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ButtonState();
  }
}

class ButtonState extends State<StateButton> {
  bool collect = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        IconButton(
          icon: new Icon(
            collect ? Icons.star : Icons.star_border,
            color: collect ? Colors.red : Colors.blue,
          ),
          onPressed: () {
            setState(() {
              collect = !collect;
              if (collect)
                count++;
              else
                count--;
            });
          },
        ),
        Text(
          count.toString(),
          style: new TextStyle(
            color: collect ? Colors.red : null,
          ),
        ),
      ],
    );
  }
}
