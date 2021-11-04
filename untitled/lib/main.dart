import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key, required this.index, required this.tekst})
      : super(key: key);
  final bool index;
  final String tekst;

  @override
  State<RandomWords> createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    bool c = widget.index;
    TextStyle styl = const TextStyle(fontSize: 18);
    return ListTile(
      title: Text(
        widget.tekst,
        style: styl,
      ),
      trailing: Icon(
        c ? Icons.favorite : Icons.favorite_border,
        color: c ? Colors.red : null,
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> x = [false];
  List<String> y = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(backgroundColor: Colors.grey,
        drawer: Drawer(
            elevation: 50,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    "Generator",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  tileColor: Colors.grey,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  title: Text(
                    "ulubione",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  tileColor: Colors.grey,
                  onTap: () {
                    Navigator.of(context).push(
                      // Add lines from here...
                      MaterialPageRoute<void>(
                        builder: (context) {
                          List<String> z = [];
                          for(int i=0;i<x.length;i++){if(x[i])z.add(y[i]);}
                          final tiles = z.map(
                            (pair) {
                              return ListTile(
                                title: Text(
                                  pair,
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            },
                          );
                          final divided = tiles.isNotEmpty
                              ? ListTile.divideTiles(
                                  context: context,
                                  tiles: tiles,
                                ).toList()
                              : <Widget>[];

                          return Scaffold(
                            appBar: AppBar(
                              title: const Text('Saved Suggestions'),
                            ),
                            body: ListView(children: divided),
                          );
                        },
                      ), // ...to here.
                    );
                  },
                ),
              ],
            )),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 40,
          shadowColor: Colors.black,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Generator",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height - 85,
                  color: Colors.grey.shade200,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        if (index >= x.length) x.add(false);
                        final wordPair = WordPair.random();
                        if (index >= y.length) y.add(wordPair.asPascalCase);
                        return FlatButton(
                          color: Colors.black12,
                          splashColor: Colors.white70,
                          child: RandomWords(
                            index: x[index],
                            tekst: y[index],
                          ),
                          onPressed: () {
                            setState(() {
                              x[index] = !x[index];
                            });
                          },
                        );
                      })),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
