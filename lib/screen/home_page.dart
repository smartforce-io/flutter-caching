import 'package:fetchingapp/provider/database.dart';
import 'package:fetchingapp/provider/google_authentication.dart';
import 'package:fetchingapp/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fetchingapp/screen/json_page.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
          ),
          const Text(
            'Try getting Firebase data with and without Cache.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            child: const Text(
              'Show Firebase Data',
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
          const SizedBox(height: 50),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(user.displayName.toString()),
              subtitle: Text(user.email.toString()),
              trailing: IconButton(
                  onPressed: () {
                    FirebaseService().signOutFromGoogle();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  icon: const Icon(Icons.logout)),
            ),
            elevation: 8,
          ),
        ],
      )),
    );
  }
}
