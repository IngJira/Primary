import 'package:basicflutter/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit

  // Method
  Widget signOutButton() {
    return IconButton(
      onPressed: () {
        myAlert();
      },
      icon: Icon(Icons.exit_to_app),
      tooltip: "Sign Out",
    );
  }

  void myAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are You Sure ?"),
            content: Text("Do You Want to Sign Out ?"),
            actions: [
              cancelButton(),
              okButton(),
            ],
          );
        });
  }

  Widget okButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
      child: Text("OK"),
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Cancel"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Service"),
        actions: [signOutButton()],
      ),
      body: Text("Body"),
    );
  }
}
