import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            const Button(fruit: 'Apple'),
            const Button(fruit: 'Orange'),
            const Button(fruit: 'Banana'),
            Text(
              'My favorite fruit is: ' + Provider.of<Favorites>(context).fruit,
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}

class Favorites extends ChangeNotifier {
  String fruit = 'unknown';

  void changeFruit(String newFruit) {
    fruit = newFruit;
    notifyListeners();
  }
}

class Button extends StatelessWidget {
  const Button({required this.fruit, Key? key}) : super(key: key);
  final String fruit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Provider.of<Favorites>(context, listen: false).changeFruit(fruit);
        },
        child: Text(fruit, style: const TextStyle(fontSize: 20)));
  }
}
