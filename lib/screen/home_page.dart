// import 'package:fetchingapp/provider/api.dart';
// import 'package:fetchingapp/provider/database.dart';
import 'package:fetchingapp/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:fetchingapp/screen/json_page.dart';

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
            'Try getting Json data with and without Cache.',
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
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text(
              'Clean DB',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              cleanDB();
            },
          ),
        ],
      )),
    );
  }
}
