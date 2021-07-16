import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/auth_controller.dart';
import 'package:nimu_todos/pages/homepage.dart';

final controller = Get.put(AuthController());

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/login.png'),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Required';
                    } else if (val.length < 6) {
                      return 'Password must be atleast 6';
                    } else {
                      return null;
                    }
                  }),
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width / 3,
            ),
            InkWell(
              onTap: () async {
                await controller.validLoginUser(
                    emailController.text, passwordController.text).then((value) => Get.to(HomePage()));
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'If you already have account,  '),
              TextSpan(
                  text: 'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(HomePage());
                    })
            ])),
          ],
        ),
      ),
    );
  }
}
