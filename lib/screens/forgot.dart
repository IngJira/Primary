import 'package:basicflutter/screens/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString = "";

  // Method
  Future sendPasswordResetEmail(String emailString) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailString);
    } catch (err) {
      print(err.toString());
    }
  }

  Widget content() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            emailText(),
          ],
        ),
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36.0,
            color: Colors.blue.shade700,
          ),
          labelText: "Email : ",
          labelStyle: TextStyle(
            color: Colors.blue.shade700,
          ),
        ),
        onSaved: (String? value) {
          emailString = value.toString().trim();
        },
      ),
    );
  }

  @override
  Widget backButton() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: Colors.blue.shade700,
      ),
    );
  }

  Widget showTitle() {
    return ListTile(
      leading: Icon(
        Icons.email,
        size: 48.0,
        color: Colors.green,
      ),
      title: Text(
        "Success",
        style: TextStyle(
          color: Colors.green,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget okButton() {
    return TextButton(
        onPressed: () async {
          await sendPasswordResetEmail(emailString);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text("OK"));
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTitle(),
            content: Text("Please check your email"),
            actions: [okButton()],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.brown.shade800],
              radius: 0.8,
            ),
          ),
          child: Stack(children: [
            backButton(),
            content(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        child: Icon(
          Icons.navigate_next,
          size: 36.0,
        ),
        onPressed: () {
          myAlert();
        },
      ),
    );
  }
}
