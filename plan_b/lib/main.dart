import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/home.dart';
import 'package:plan_b/src/pages/map.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget{
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _index = 0;

  List _pages = [
    Home(),
    Map(),
  ];

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: _pages[_index],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 30,
            unselectedItemColor: Color(0xFFEBEBEB),
            selectedItemColor: Color(0xFF27AB00),
            backgroundColor: Colors.white,
            elevation: 0.0,
            currentIndex: _index,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Image.asset('assets/images/metaverse2.png'), label: 'map',activeIcon: Image.asset('assets/images/metaverse3.png')),
            ],),
        ),
      );
  }
}