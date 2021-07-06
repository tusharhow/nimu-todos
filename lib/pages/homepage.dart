import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nimu_todos/controllers/auth_controller.dart';
import 'package:nimu_todos/pages/login.dart';
import 'package:nimu_todos/pages/signup.dart';

final fireController = Get.put(AuthController());

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nimu TODOS'),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => SignUp());
            },
            child: Text('Add User'),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => Login());
            },
            child: Text('Login'),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              fireController.userSignOut();
            },
            child: Text('Sign Out'),
          ),
        ],
      ))),
    );
  }
}
