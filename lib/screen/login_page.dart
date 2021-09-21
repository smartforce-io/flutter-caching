import 'package:fetchingapp/provider/google_authentication.dart';
import 'package:fetchingapp/screen/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void click() async {
    await FirebaseService().signInwithGoogle().then((user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HomePage(user)));
    });
  }

   Widget googleLoginButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45))),
        onPressed: click,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(image: AssetImage('images/google_logo.png'), height: 35),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Sign in with Google',
                      style: TextStyle(color: Colors.grey, fontSize: 25)))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: googleLoginButton(),
      ),
    );
  }
}
