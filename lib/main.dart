import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Welcome to Flutter", home: new RandomWords(),theme: new ThemeData(
      primaryColor: Colors.white,
    ),);
  }
}

//创建一个随机单词类
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordState();
  }
}

//创建一个单词状态类，泛型传要加状态的类
class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _bigFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _bigFont,
            maxLines: 1,
          ),
        );
      });
      final divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Saved Suggestions"),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildRow(WordPair pair) {
    final alreadySave = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigFont,
      ),
      trailing: new Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySave)
            _saved.remove(pair);
          else
            _saved.add(pair);
        });
      },
    );
  }
}
