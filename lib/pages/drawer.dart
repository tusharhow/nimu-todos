import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/auth_controller.dart';
import 'package:nimu_todos/pages/about_dev.dart';

import 'package:nimu_todos/pages/login.dart';
import 'package:nimu_todos/pages/signup.dart';
import 'package:url_launcher/url_launcher.dart';

final controller = Get.put(AuthController());

class DrawerHome extends StatefulWidget {
  const DrawerHome({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: DrawerHeader(
              child: CircleAvatar(
                child: Text(
                  "Your Daily TODO Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Galada'),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text("About Us"),
            leading: Icon(Icons.menu),
            onTap: () {
              Get.to(() => AboutDev());
            },
          ),
          Divider(),
          InkWell(
            onTap: () async {
              await launch(
                  'https://play.google.com/store/apps/details?id=com.metushar.app');
            },
            child: ListTile(
              title: Text(
                "Rate Our Apps",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontFamily: 'Galada',
                    fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.sentiment_very_satisfied,
                  size: 23, color: Colors.teal),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(Login());
              },
              child: Text('Login')),
          ElevatedButton(
              onPressed: () {
                Get.to(SignUp());
              },
              child: Text('Sign Up')),
          ElevatedButton(
              onPressed: () {
                controller.userSignOut();
              },
              child: Text('Sign Out')),
        ],
      ),
    );
  }
}
