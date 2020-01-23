import 'package:bandnames/band_list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Names',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BandListScreen(title: 'Band Names'),
    );
  }
}

