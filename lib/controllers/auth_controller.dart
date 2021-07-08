import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';
import 'package:nimu_todos/pages/login.dart';

final formKey = GlobalKey<FormState>();

class AuthController extends GetxController {
  final userAuth = FirebaseAuth.instance;
  final auth = FirebaseAuth.instance;
  final firebaseInstance = FirebaseFirestore.instance;


  Future addUser(String emai, String pass) async {
    String uid = userAuth.currentUser!.uid;
    final time = DateTime.now();
    try {
      await userAuth
          .createUserWithEmailAndPassword(email: emai, password: pass)
          .then((value) {
        try {
          FirebaseFirestore.instance.collection('users').doc(uid).set({
            'id': uid,
            'creation': time.toString(),
            'email': emai,
            'password': pass
          });
          return Get.to(Login());
        } catch (e) {}
      });
      //     .then((value) {})
      //     .catchError((onError) {
      //   Get.snackbar("Error while sign up ", onError.message);
      // })
      // .then((value) {
      //   FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(value.user!.uid)
      //       .set({
      //     "email": value.user!.email,
      //   });
      // })
      // .then((value) {})
      // .catchError((onError) {
      //   Get.snackbar("Error while sign up ", onError.message);
      // });
    }
    // String uid = userAuth.currentUser!.uid;
    // final time = DateTime.now();
    // await FirebaseFirestore.instance
    //     .collection('accounts')
    //     .doc(uid)
    //     .collection('users')
    //     .doc(uid)
    //     .set({
    //   'id': uid,
    //   'email': emai,
    //   'password': pass,
    //   'time': time.toString(),
    //   // });
    // }

    // );
    catch (e) {
      Get.snackbar('Error while sign up, Try again.', '');
    }
  }
}

Future validLoginUser(String emailLog, String passLog) async {
  try {
    formKey.currentState!.validate();
    await auth
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
