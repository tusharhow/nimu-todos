import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nimu_todos/controllers/auth_controller.dart';
import 'package:nimu_todos/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final fireController = Get.put(AuthController());

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nimu TODOS'),
        ),
        body: Center(
          child: Text('HomePage'),
        ));
  }
}
