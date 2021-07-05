import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/auth_controller.dart';
import 'package:nimu_todos/pages/signup.dart';

final controller = Get.put(AuthController());

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('images/login.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.green,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              controller.loginUser(
                  emailController.text, passwordController.text);
            },
            child: Container(
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => SignUp());
            },
            child: Container(
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ],
      ),
    );
  }
}
