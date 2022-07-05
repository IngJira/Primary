// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:basicflutter/screens/authen.dart';
import 'package:basicflutter/screens/my_service.dart';
import 'package:basicflutter/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      var user = firebaseAuth.currentUser;
      if (user != null) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => MyService());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      }
    } catch (error) {
      print("Already logged in");
    }
  }

  Widget showLogo() {
    return SizedBox(
      width: 120.0,
      height: 120.0,
      child: Image.asset("images/logo.png"),
    );
  }

  Widget showAppName() {
    return Text(
      "Kikunojou Shopping Mall",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.orange.shade700,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: "Caveat",
      ),
    );
  }

  Widget signInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade700,
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
      child: const Text(
        "Sign In",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget signUpButton() {
    return OutlinedButton(
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => const Register());
        Navigator.of(context).push(materialPageRoute);
      },
      child: const Text("Sign Up"),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        signInButton(),
        const SizedBox(width: 4.0),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white,
                Colors.brown.shade800,
              ],
              radius: 1.0,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showLogo(),
                showAppName(),
                const SizedBox(
                  height: 8.0,
                ),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
