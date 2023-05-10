import 'dart:async';

import 'package:api_rest/login-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirection();
  }

  void redirection(){
    Timer(const Duration(seconds: 25), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          child: Icon(CupertinoIcons.cloud_bolt_rain_fill, color: Colors.white, size: 70,)
        ),
      ),
    );
  }
}
