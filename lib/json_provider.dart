import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiProvider {
  final url = 'https://jsonplaceholder.typicode.com/comments';

  Future getData() async {
    if (kIsWeb) {
      return getFromApi();
    }
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/cache.json');

    if (file.existsSync()) {
      final data = file.readAsStringSync();
      final res = json.decode(data);
      return res;
    } else {
      return getFromApi();
    }
  }

  Future getFromApi() async {
    final req = await http.get(Uri.parse(url));
    if (req.statusCode == 200) {
      final body = req.body;
      // cache data
      if (!kIsWeb) {
        var dir = await getTemporaryDirectory();
        File file = File(dir.path + '/cache.json');
        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
      }
      return json.decode(body);
    } else {
      return json.decode(req.body);
    }
  }

  Future removeCacheFile() async {
    if (kIsWeb) {
      return;
    }
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/cache.json');
    file.delete();
  }
}
