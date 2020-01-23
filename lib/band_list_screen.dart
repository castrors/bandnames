import 'package:bandnames/band.dart';
import 'package:flutter/material.dart';

class BandListScreen extends StatefulWidget {
  BandListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BandListScreenState createState() => _BandListScreenState();
}

class _BandListScreenState extends State<BandListScreen> {
  static const List<Band> _bandList = [
    Band(name: 'Metallica', votes: 1),
    Band(name: 'Fall Out Boy', votes: 2),
    Band(name: 'Offspring', votes: 3),
    Band(name: 'Gorillaz', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: _bandList.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, _bandList[index])));
  }

  Widget _buildListItem(context, band) {
    return ListTile(
      title: Text(band.name),
      trailing: CircleAvatar(
        child: Text(band.votes.toString()),
      ),
    );
  }
}
