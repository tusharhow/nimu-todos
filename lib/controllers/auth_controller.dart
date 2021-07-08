import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';
import 'package:nimu_todos/pages/login.dart';

final formKey = GlobalKey<FormState>();
final userAuth = FirebaseAuth.instance;
final emailController = TextEditingController();
final passwordController = TextEditingController();
final _auth = FirebaseAuth.instance;

class AuthController extends GetxController {
  String uid = _auth.currentUser!.uid;

  Future addUser(String emai, String pass) async {
    try {
      var time = DateTime.now();
      await _auth
          .createUserWithEmailAndPassword(email: emai, password: pass)
          .then((value) => {
                FirebaseFirestore.instance.collection('users').add({
                  'email': emai,
                  'password': pass,
                  'id': uid,
                  'creation': time.toString()
                })
              })
          .then((value) => Get.offAll(Login()))
          .catchError((onError) {
        Get.snackbar("Error while Sign up", onError.message);
      });
    } catch (e) {
      print('e');
    }
  }

  Future validLoginUser(String emailLog, String passLog) async {
    try {
      formKey.currentState!.validate();
      await _auth
          .signInWithEmailAndPassword(email: emailLog, password: passLog)
          .then((value) => Get.offAll(HomePage()))
          .catchError((onError) {
        Get.snackbar("Error while sign in ", onError.message);
      });
    } catch (e) {
      print('error');
    }
  }

  void userSignOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
