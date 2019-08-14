import 'package:flutter/material.dart';
import 'package:manganese_app/ui/manganese_alloys_view.dart';
import 'package:manganese_app/ui/map_view.dart';
import 'package:manganese_app/ui/molecules_view.dart';
import 'package:manganese_app/ui/periodic_table_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
          accentColor: Colors.indigo[200]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  List<Widget> children;

  @override
  void initState() {
    children = [
      PeriodicTableView(),
      MapView(),
      ManganeseSea(),
      MoleculesView()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentPage == 2
          ? null
          : AppBar(
              title: Text('Manganês'),
            ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: children[currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int i) => setState(() => currentPage = i),
          currentIndex: currentPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_on), title: Text('Tabela')),
            BottomNavigationBarItem(
                icon: Icon(Icons.pin_drop), title: Text('Mapa')),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), title: Text('Ligas')),
            BottomNavigationBarItem(
                icon: Icon(Icons.share), title: Text('Compostos'))
          ]),
    );
  }
}
