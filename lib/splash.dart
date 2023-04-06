import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:todolist/loginScreen.dart';
import 'package:todolist/main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>  LoginScreen()), (route) => false);
     });
     
  }

  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Hero(
          tag: "logo",
        child: Image.asset('/assets/twitter.svg'),
      ),) 
    );
  }
}