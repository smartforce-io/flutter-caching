import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiProvider {
  final url = 'https://jsonplaceholder.typicode.com/comments';

  Future getData() async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/cache.json');
    // file.delete();

    if (file.existsSync()) {
      // read from cache
      final data = file.readAsStringSync();
      final res = json.decode(data);
      return res;
    } else {
      // fetch from network
      try {
        final req = await http.get(Uri.parse(url));
        if (req.statusCode == 200) {
          final body = req.body;
          // cache data
          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = json.decode(body);
          return res;
        } else {
          return json.decode(req.body);
        }
      } catch (e) {
        // ignore
      }
    }
  }

  Future removeCacheFile() async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/cache.json');
    file.delete();
  }
}
