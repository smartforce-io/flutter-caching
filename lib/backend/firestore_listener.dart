import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class FirestoreChanges extends ChangeNotifier {
  List<Map<String, dynamic>> list = [];
  Map<String, dynamic> map = {};
  bool isFirstBoot = true;

  void listenOnFirestoreChanges() {
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .snapshots()
        .listen((event) {
      if (isFirstBoot) {
        cleanDB();
        for (var change in event.docChanges) {
          map = {'name': change.doc.data()!['name'], 'doc_id': change.doc.id};
          list.add(map);
        }
        print('first boot');
        print(list);
        insertBatchSQLite(list: list);
        isFirstBoot = false;
      } else {
        for (var change in event.docChanges) {
          map = {'name': change.doc.data()!['name'], 'doc_id': change.doc.id};
          if (change.type == DocumentChangeType.added) {
            insertSQLite(item: map);
          } else if (change.type == DocumentChangeType.modified) {
            updateSQLite(item: map);
          } else if (change.type == DocumentChangeType.removed) {
            deleteSQLite(item: map);
          }
          print('Change type: ${change.type};\n'
              'Doc ID: ${change.doc.id}\n'
              'Data: ${change.doc.data()}\n\n');
        }
      }
      notifyListeners();
    });
  }
  
Future<List<Map>> readSQLiteCache() async {
  final db = await cacheDatabase();
  var cache = db.query('cache');
  var value = cache.then((value) {
    return value;
  });
  return value;
}


}

// class Firestore {
//   Future getData() async {
//     return readCache().then((value) async {
//       return value;
//     });
//   }
// }

class ApiProvider {
  // final url = 'https://jsonplaceholder.typicode.com/comments';

  // Future getData() async {
  //   if (kIsWeb) {
  //     return _getFromApi();
  //   }
  //   return _getFromDB();
  // }

  // Future getDataForFirestore() async {
  //   return readSQLiteCache().then((value) async {
  //     if (value.isNotEmpty) {
  //       print('READING FROM DB, NUMBER OF ENTRIES: ${value.length}');
  //       callFirestore();
  //       return value;
  //     } else {
  //       return callFirestore();
  //     }
  //   });
  // }

  Future callFirestore() async {
    cleanDB();
    print('fetching from network');
    var data = await FirebaseFirestore.instance
        .collection('flutter-caching')
        .orderBy('name')
        .get();
    var array = data.docs.map((e) {
      return {'name': e['name']};
    }).toList();
    // await insertSQLite(list: array);
    return array;
  }

  // Future _getFromDB() async {
  //   return readJsonCache().then((value) {
  //     if (value.isNotEmpty) {
  //       print('reading from db');
  //       return value;
  //     } else {
  //       print('fetching from network');
  //       return _getFromApi();
  //     }
  //   });
  // }

//   Future _getFromApi() async {
//     try {
//       final req = await http.get(Uri.parse(url));
//       if (req.statusCode == 200) {
//         final body = req.body;
//         final jsonDecoded = json.decode(body);

//         // cache data
//         if (!kIsWeb) {
//           await cleanDB();
//           await addBatchOfEntries(entries: jsonDecoded);
//         }
//         return json.decode(body);
//       } else {
//         return json.decode(req.body);
//       }
//     } catch (e) {
//       // ignore
//     }
//   }
// }
}
