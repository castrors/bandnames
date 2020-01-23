import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BandListScreen extends StatefulWidget {
  BandListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BandListScreenState createState() => _BandListScreenState();
}

class _BandListScreenState extends State<BandListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('bands').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading ...');
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['name']),
      trailing: CircleAvatar(
        child: Text(document['votes'].toString()),
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
          await transaction
              .update(freshSnap.reference, {'votes': freshSnap['votes'] + 1});
        });
      },
      onLongPress: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
          await transaction.delete(freshSnap.reference);
        });
      },
    );
  }
}
