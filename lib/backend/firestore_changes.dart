import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreChanges extends ChangeNotifier {
  String changeStr = '';

  void listenOnFirestoreChanges() {
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .snapshots()
        .listen((event) {
      changeStr = '';
      for (var change in event.docChanges) {
        // print('Change type: ${change.type}; Data: '
        //     '${change.doc.data()}\n');
        changeStr = changeStr +
            'Change type: ${change.type};\n'
                'Doc ID: ${change.doc.id}\n'
                'Data: ${change.doc.data()}\n';
      }
      notifyListeners();
      // changeStr = '';
    });
  }
}
