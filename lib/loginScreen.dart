import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todolist/landing.dart';
import 'package:todolist/registerscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello,\nLogin Now',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(height: 40.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(223, 161, 93, 68).withOpacity(0.5),
                hintText: 'Your email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(223, 161, 93, 68).withOpacity(0.5),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 3.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => RegisterScreen()), (route) => false);
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                  .then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Task()), (route) => false))
                  .onError((error, stackTrace) => print("Error on login"));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(223, 183, 26, 231),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
