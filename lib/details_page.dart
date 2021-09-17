import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.body, {Key? key}) : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
