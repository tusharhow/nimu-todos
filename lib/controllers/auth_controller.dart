import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final formKey = GlobalKey<FormState>();
final userAuth = FirebaseAuth.instance;
final emailController = TextEditingController();
final passwordController = TextEditingController();
final _auth = FirebaseAuth.instance;

class AuthController extends GetxController {
  // Future<String> getCurrentUID() async {
  //   final uid = _auth.currentUser!.uid;
  //   return uid;
  // }

  // final uid = _auth.currentUser?.uid;

  Future<void> addUser(String emai, String pass) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      var time = DateTime.now();
      await _auth
          .createUserWithEmailAndPassword(email: emai, password: pass)
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('accounts')
                    .doc(uid)
                    .collection('users')
                    .add({
                  'email': emai,
                  'password': pass,
                  'creation': time.toString(),
                  'id': uid,
                })
              });
    } catch (e) {
      print('error creating account');
    }
  }

  Future<void> validLoginUser(String emailLog, String passLog) async {
    try {
      formKey.currentState!.validate();
      await _auth.signInWithEmailAndPassword(
          email: emailLog, password: passLog);
    } catch (e) {
      print('error sign in');
    }
  }

  void userSignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('error sign out');
    }
  }
}
