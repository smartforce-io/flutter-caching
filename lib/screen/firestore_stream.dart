import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/provider/database.dart';
import 'package:flutter/material.dart';

class StreamFireStore extends StatefulWidget {
  const StreamFireStore({Key? key}) : super(key: key);

  @override
  _StreamFireStoreState createState() => _StreamFireStoreState();
}

class _StreamFireStoreState extends State<StreamFireStore> {
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
                  print(snapshot.data!.docs.length);
                  var data = snapshot.data!.docs.map((e) {
                    return {'name': e['name']};
                  }).toList();
                  // cleanDB();
                  addBatchOfFirestore(list: data);
                  var db = readCache().then((value) {
                    return value;
                    // if (value.isNotEmpty) {
                    //   // print('reading from db');
                    //   // print('reading from db');
                    //   // return Text('database has data');
                    // }
                    // print(value);
                  });

                  // readCache();

                  // print(data);
                  return ListView(
                    children: snapshot.data!.docs.map((e) {
                      return ListTile(
                        title: Text(e['name']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
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
