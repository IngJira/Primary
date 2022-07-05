// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

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
  String login = "...";

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36.0,
        color: Colors.purple,
      ),
      title: Text("List Product"),
      subtitle: Text("Show All List Product"),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddList() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add,
        size: 36.0,
        color: Colors.green.shade900,
      ),
      title: Text("Add List Product"),
      subtitle: Text("Add New Product to Database"),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        login = user.displayName.toString();
      });
    }
    print("login = $login");
  }

  Widget showLogin() {
    return Text(
      "Logged in by $login",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget showAppName() {
    return Text(
      "Kikunojou Shopping Mall",
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.orange.shade700,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: "Caveat",
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset("images/logo.png"),
    );
  }

  Widget showHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/shop.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          showLogo(),
          showAppName(),
          SizedBox(
            height: 6.0,
          ),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: [
          showHead(),
          showListProduct(),
          showAddList(),
        ],
      ),
    );
  }

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
      drawer: showDrawer(),
    );
  }
}
