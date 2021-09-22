import 'package:fetchingapp/provider/database.dart';
import 'package:fetchingapp/provider/google_authentication.dart';
import 'package:fetchingapp/screen/firestore_stream.dart';
import 'package:fetchingapp/screen/firestore_future.dart';
import 'package:fetchingapp/screen/json_caching.dart';
import 'package:fetchingapp/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Try getting Firebase data with and without Cache.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          testSectionButton(
              context: context,
              name: 'Future Firestore',
              widget: const FutureFireStore()),
          const SizedBox(height: 10),
          testSectionButton(
              context: context,
              name: 'Stream Firestore',
              widget: const StreamFireStore()),
          const SizedBox(height: 10),
          cleanDBbutton(),
          const SizedBox(height: 10),
          testSectionButton(
              context: context,
              name: 'Old Json Caching Example',
              widget: const JsonPage()),
          const SizedBox(height: 50),
          userProfileCard(context: context, user: user)
        ],
      )),
    );
  }
}

Widget testSectionButton(
    {required BuildContext context,
    required String name,
    required Widget widget}) {
  return ElevatedButton(
    child: Text(
      name,
      style: const TextStyle(fontSize: 20),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    },
  );
}

Widget cleanDBbutton() {
  return ElevatedButton(
    child: const Text(
      'Clean DB',
      style: TextStyle(fontSize: 20),
    ),
    onPressed: () {
      cleanDB();
    },
  );
}

Widget userProfileCard({required BuildContext context, required User user}) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.person),
      title: Text(user.displayName.toString()),
      subtitle: Text(user.email.toString()),
      trailing: IconButton(
          onPressed: () {
            FirebaseService().signOutFromGoogle();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const LoginPage()));
          },
          icon: const Icon(Icons.logout)),
    ),
    elevation: 8,
  );
}
