import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/auth_controller.dart';

final controller = Get.put(AuthController());

class SignUp extends StatelessWidget {
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
            image: AssetImage('images/signup.png'),
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
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              controller.addUser(emailController.text, passwordController.text);
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
