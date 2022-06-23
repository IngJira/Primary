import 'package:basicflutter/screens/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString = "", passwordString = "";

  // Method
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

  Widget content() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showAppName(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }

  Widget showAppName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        showLogo(),
        showText(),
      ],
    );
  }

  Widget showLogo() {
    return Container(
      width: 48.0,
      height: 48.0,
      child: Image.asset("images/logo.png"),
    );
  }

  Widget showText() {
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

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: Colors.blue.shade700,
          ),
          labelText: "Password : ",
          labelStyle: TextStyle(
            color: Colors.blue.shade700,
          ),
        ),
        onSaved: (String? value) {
          passwordString = value.toString().trim();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailString, password: passwordString)
          .then((response) {
        print("Authen Success");
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => MyService());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      }).catchError((response) {
        String title = response.code;
        String message = response.message;
        myAlert(title, message);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Widget showTitle(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        size: 48.0,
        color: Colors.red,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget okButton() {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("OK"));
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTitle(title),
            content: Text(message),
            actions: [okButton()],
          );
        });
  }

  @override
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
          formKey.currentState?.save();
          print("email = $emailString, password = $passwordString");
          checkAuthen();
        },
      ),
    );
  }
}
