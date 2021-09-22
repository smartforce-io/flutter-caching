import 'package:flutter/material.dart';

class ProviderTestPage extends StatefulWidget {
  const ProviderTestPage({Key? key}) : super(key: key);

  @override
  _ProviderTestPageState createState() => _ProviderTestPageState();
}

class _ProviderTestPageState extends State<ProviderTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Test'),
      ),
      body: Center(
        child: Column(
          children: [
            Button(fruit: 'Apple'),
            Button(fruit: 'Orange'),
            Button(fruit: 'Banana')
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({required this.fruit, Key? key}) : super(key: key);
  final String fruit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(fruit));
  }
}
