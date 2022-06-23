// ignore_for_file: avoid_print

import 'package:basicflutter/screens/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString = "", emailString = "", passwordString = "";

  // Method
  Widget registerButton() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          // เก็บข้อมูลลงตัวแปรสำเร็จ
          registerThread();
        }
      },
      icon: const Icon(
        Icons.cloud_upload,
      ),
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailString, password: passwordString)
          .then((response) {
        print("Register Success for Email = $emailString");
        setupDisplayName();
      }).catchError((response) {
        String title = response.code;
        String message = response.message;
        print("title = $title, message = $message");
        myAlert(title, message);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  // ติดค่า null ใช้ไม่ได้

  // Future<void> setupDisplayName() async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   await firebaseAuth.currentUser().then((response) {
  //     UserUpdateInfo userUpdateInfo = UserUpdateInfo();
  //     userUpdateInfo.displayName = nameString;
  //     response.updateProfile(userUpdateInfo);

  //     MaterialPageRoute materialPageRoute =
  //         MaterialPageRoute(builder: (BuildContext context) => MyService());
  //     Navigator.of(context).pushAndRemoveUntil(
  //         materialPageRoute, (Route<dynamic> route) => false);
  //   });
  // }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    var user = firebaseAuth.currentUser;
    if (user != null) {
      user.updateDisplayName(nameString);

      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  Widget nameText() {
    return TextFormField(
      style: const TextStyle(
        color: Colors.purple,
      ),
      decoration: const InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.purple,
          size: 48.0,
        ),
        labelText: "Display Name :",
        labelStyle: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
        helperText: "Type Your Nickname to Display",
        helperStyle: TextStyle(
          color: Colors.purple,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Please Fill Your Name in the Blank";
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        nameString = value!.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.green.shade800,
      ),
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.green.shade800,
          size: 48.0,
        ),
        labelText: "Email :",
        labelStyle: TextStyle(
          color: Colors.green.shade800,
          fontWeight: FontWeight.bold,
        ),
        helperText: "Type Your Email",
        helperStyle: TextStyle(
          color: Colors.green.shade800,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String? value) {
        if (!((value!.contains("@")) && (value.contains(".")))) {
          return "Please Type Email in Exp. you@email.com";
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        emailString = value!.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      style: TextStyle(
        color: Colors.blue.shade800,
      ),
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.blue.shade800,
          size: 48.0,
        ),
        labelText: "Password :",
        labelStyle: TextStyle(
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
        ),
        helperText: "Type Your Password more than 6 Characters",
        helperStyle: TextStyle(
          color: Colors.blue.shade800,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String? value) {
        if (value!.length < 7) {
          return "Password More than 6 Characters";
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        passwordString = value!.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade800,
        title: const Text("Register"),
        actions: [registerButton()],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: [
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
