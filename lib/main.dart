import 'package:flutter/material.dart';

import 'manganese_sea.dart';
import 'single_manganese.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> _manganeseAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _manganeseAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Manganês'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedBuilder(
              animation: _manganeseAnimation,
              builder: (context, _) {
                List<Widget> widgets = <Widget>[];
                for (int i = 0; i < 28; i++) {
                  if (i == 28) {
                    widgets.add(Hero(
                        tag: 'manganese' + i.toString(),
                        child: Material(
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: CustomPaint(
                              painter: AtomPainter.silicon(
                                  _manganeseAnimation.value),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ManganeseSea())),
                              )),
                        )));
                  } else {
                    widgets.add(Hero(
                      tag: 'manganese' + i.toString(),
                      child: Material(
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: CustomPaint(
                            painter: AtomPainter.manganese(
                                _manganeseAnimation.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(fontSize: 50.0)),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ManganeseSea())),
                            )),
                      ),
                    ));
                  }
                }
                return Stack(
                  children: widgets,
                );
              }),
        ),
      ),
    );
  }
}
