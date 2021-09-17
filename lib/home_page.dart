import 'package:fetchingapp/json_provider.dart';
import 'package:flutter/material.dart';
import 'package:fetchingapp/json_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caching Data Test'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Try getting Json data with and without Cache file.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            child: const Text(
              'Show Json Data',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JsonPage()),
              );
            },
          ),
          ElevatedButton(
            child: const Text(
              'Remove Cache File',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              ApiProvider().removeCacheFile();
            },
          ),
        ],
      )),
    );
  }
}
