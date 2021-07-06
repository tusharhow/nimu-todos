import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';
import 'package:nimu_todos/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt(
    'onBoard',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nimu TODOS',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: isviewed == 0 || isviewed == null ? SplashScreen() : HomePage(),
    );
  }
}
