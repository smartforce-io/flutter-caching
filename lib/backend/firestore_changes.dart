import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/foundation.dart';

class FirestoreChanges extends ChangeNotifier {
  String changeStr = '';
  // List<Map<String, dynamic>> list = [];
  Map<String, dynamic> map = {};

  void listenOnFirestoreChanges() {
    cleanDB();
    // _checkInternetConnectivity();

    FirebaseFirestore.instance
        .collection('flutter-caching')
        .snapshots()
        .listen((event) {
      print('CHANGE!');
      changeStr = '';
      // list = [];
      for (var change in event.docChanges) {
        map = {'name': change.doc.data()!['name'], 'doc_id': change.doc.id};
        if (change.type == DocumentChangeType.added) {
          insertSQLite(item: map);
        } else if (change.type == DocumentChangeType.modified) {
          updateSQLite(item: map);
          print('cached modified');
        }

        // list.add(map);
        print('Change type: ${change.type};\n'
            'Doc ID: ${change.doc.id}\n'
            'Data: ${change.doc.data()}\n\n');
        changeStr = changeStr +
            'Change type: ${change.type};\n'
                'Doc ID: ${change.doc.id}\n'
                'Data: ${change.doc.data()}\n\n';
      }
      notifyListeners();
      // addToSQLite(list: list);
      // print(list);
    });
  }
}

// Future<void> _checkInternetConnectivity() async {
//   var result = await Connectivity().checkConnectivity();
//   if (result != ConnectivityResult.none) {
//     cleanDB();
//     print('none');
//     // return 'none';
//   }
// }
