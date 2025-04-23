import 'package:flutter/material.dart';
import 'screens/basic_hero_screen.dart';
import 'screens/custom_transition_hero_screen.dart';
import 'screens/basic_radial_hero_screen.dart';
import 'screens/circular_clip_hero_screen.dart';
import 'screens/background_expansion_hero_screen.dart';

// main entry point for the application
void main() {
  runApp(MyApp());
}

// root application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// home page with navigation between hero animation examples
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // tracks currently selected animation example
  int _selectedIndex = 0;

  // list of different hero animation screens
  final List<Widget> _pages = [
    BasicHero(),
    CustomTransitionHero(),
    BasicRadialHero(),
    CircularClipHero(),
    BackgroundExpansionHero(),
  ];

  // handle bottom navigation bar selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Animation"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Basic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Custom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Basic Radial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Circular Clip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Background Expansion',
          ),
        ],
      ),
    );
  }
}