import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/material.dart';

class FirestoreCollectionCaching extends StatefulWidget {
  const FirestoreCollectionCaching({Key? key}) : super(key: key);

  @override
  _FirestoreCollectionCachingState createState() =>
      _FirestoreCollectionCachingState();
}

class _FirestoreCollectionCachingState
    extends State<FirestoreCollectionCaching> {
  @override
  Widget build(BuildContext context) {
    readCache();
    cleanDB();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Collection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text('List'),
          ),
          inputfield(),
        ],
      ),
    );
  }
}

Widget inputfield() {
  final textController = TextEditingController();

  void addEntry() {
    if (textController.text == '') {
      return;
    }

    FirebaseFirestore.instance
        .collection('flutter-caching')
        .add({'name': textController.text});
    textController.clear();
  }

  return TextField(
      controller: textController,
      onEditingComplete: () {
        addEntry();
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_circle),
          labelText: "Input new value and click Save:",
          suffixIcon: IconButton(
            icon: const Icon(Icons.save),
            splashColor: Colors.blue,
            tooltip: "Post message",
            onPressed: () {
              addEntry();
            },
          )));
}
