import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manganese_app/ui/manganese_alloys_view.dart';
import 'package:manganese_app/ui/map_view.dart';
import 'package:manganese_app/ui/molecules_view.dart';
import 'package:manganese_app/ui/periodic_table_view.dart';

import 'bloc/bloc.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  runApp(BlocProvider<SettingsManagerBloc>(
      builder: (_) => LocalSettingsManagerBloc(), child: MyApp()));
}

final ThemeData lightTheme = ThemeData(primarySwatch: Colors.indigo);
final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
    accentColor: Colors.indigo[200]);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsManagerBloc, SettingsManagerState>(
      builder: (BuildContext context, SettingsManagerState state) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.themeOptions,
          home: MyHomePage(state.themeOptions),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.options);
  final ThemeMode options;
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
    IconData theme;
    switch (widget.options) {
      case ThemeMode.light:
        theme = Icons.brightness_high;
        break;
      case ThemeMode.dark:
        theme = Icons.brightness_3;
        break;
      case ThemeMode.system:
        theme = Icons.brightness_auto;
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Manganês'),
        actions: <Widget>[
          IconButton(
              icon: Icon(theme),
              onPressed: () {
                final int index = ThemeMode.values.indexOf(widget.options) + 1;
                int tgt = index == ThemeMode.values.length ? 1 : index;
                BlocProvider.of<SettingsManagerBloc>(context).dispatch(
                    UpdateSettingsEvent(themeOptions: ThemeMode.values[tgt]));
              })
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: children[currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).iconTheme.color
              : null,
          selectedItemColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).primaryColor
              : null,
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
