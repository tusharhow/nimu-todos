import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';
import 'package:nimu_todos/pages/login.dart';

final formKey = GlobalKey<FormState>();

class AuthController extends GetxController {
  final userAuth = FirebaseAuth.instance;
  // final auth = FirebaseAuth.instance;

  Future addUser(String emai, String pass) async {
    try {
      await userAuth
          .createUserWithEmailAndPassword(email: emai, password: pass)
          .then((value) => Get.offAll(Login()))
          .catchError((onError) {
        Get.snackbar("Error while sign up ", onError.message);
      });
      String uid = userAuth.currentUser!.uid;
      final time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('accounts')
          .doc(uid)
          .collection('users')
          .doc(uid)
          .set({
        'id': uid,
        'email': emai,
        'password': pass,
        'time': time.toString(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future validateLoginUser(String emailLog, String passLog) async {
    try {
      formKey.currentState!.validate();
      await userAuth
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
      await userAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
