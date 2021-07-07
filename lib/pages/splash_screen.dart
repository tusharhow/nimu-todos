import 'package:flutter/material.dart';
import 'package:nimu_todos/constants.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'First Screen',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
