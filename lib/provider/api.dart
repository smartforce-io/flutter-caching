import 'dart:convert';
import 'package:fetchingapp/provider/database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiProvider {
  final url = 'https://jsonplaceholder.typicode.com/comments';

  Future getData() async {
    if (kIsWeb) {
      return _getFromApi();
    }
    return _getFromDB();
  }

  Future _getFromDB() async {
    return readCache().then((value) {
      if (value.isNotEmpty) {
        print('reading from db');
        return value;
      } else {
        print('fetching from network');
        return _getFromApi();
      }
    });
  }

  Future _getFromApi() async {
    try {
      final req = await http.get(Uri.parse(url));
      if (req.statusCode == 200) {
        final body = req.body;
        final jsonDecoded = json.decode(body);

        // cache data
        if (!kIsWeb) {
          await cleanDB();
          print('db cleaned');
          await addBatchOfEntries(entries: jsonDecoded);
        }
        return json.decode(body);
      } else {
        return json.decode(req.body);
      }
    } catch (e) {
      // ginore
    }
  }
}
