import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDataPage extends StatefulWidget {
  const FirestoreDataPage({Key? key}) : super(key: key);

  @override
  _FirestoreDataPageState createState() => _FirestoreDataPageState();
}

class _FirestoreDataPageState extends State<FirestoreDataPage> {
  final textController = TextEditingController();

  void addEntry() {
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .add({'name': textController.text});
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Data'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('flutter-caching')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView(
                    children: snapshot.data!.docs.map((e) {
                      return ListTile(
                        title: Text(e['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            e.reference.delete();
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          )),
          TextField(
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
                      FirebaseFirestore.instance
                          .collection('flutter-caching')
                          .add({'name': textController.text});
                      textController.clear();
                    },
                  ))),
        ],
      ),
    );
  }
}
