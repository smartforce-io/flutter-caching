import 'package:fetchingapp/screen/home_page.dart';
import 'package:fetchingapp/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    Widget firstScreen;

    if (firebaseUser != null) {
      firstScreen = HomePage(firebaseUser);
    } else {
      firstScreen = const LoginPage();
    }

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: firstScreen,
    );
  }
}
