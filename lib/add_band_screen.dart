import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BandDetailScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const BandDetailScreen({this.document});

  @override
  _BandDetailScreenState createState() => _BandDetailScreenState();
}

class _BandDetailScreenState extends State<BandDetailScreen> {
  String _name = '';
  DocumentSnapshot document;

  @override
  void initState() {
    super.initState();
    document = widget.document;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Band'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (document != null) {
                Firestore.instance
                    .collection('bands')
                    .document(document.documentID)
                    .setData({'name': _name, 'votes': document.data['votes']});
              } else {
                Firestore.instance
                    .collection('bands')
                    .document()
                    .setData({'name': _name, 'votes': 0});
              }

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: document != null ? document.data['name'] : null,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (name) {
                _name = name;
              },
            ),
          ],
        ),
      ),
    );
  }
}
