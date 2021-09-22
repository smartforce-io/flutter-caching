import 'package:fetchingapp/backend/database.dart';
import 'package:fetchingapp/backend/google_authentication.dart';
import 'package:fetchingapp/screens/firestore_stream.dart';
import 'package:fetchingapp/screens/firestore_future.dart';
import 'package:fetchingapp/screens/json_caching.dart';
import 'package:fetchingapp/screens/login.dart';
import 'package:fetchingapp/screens/provider_test.dart';
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
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          userProfileCard(context: context, user: user),
          const SizedBox(height: 10),
          testSectionButton(
              context: context,
              name: 'Provider Test',
              widget: ProviderTestPage()),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
        ],
      ),
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
