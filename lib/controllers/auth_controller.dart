import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var userAuth = FirebaseAuth.instance;

  void addUser(String emai, String pass) async {
    try {
      await userAuth.createUserWithEmailAndPassword(
          email: emai, password: pass);
    } catch (e) {
      print(e);
    }
  }

  void loginUser(String emailLog, String passLog) async {
    try {
      await userAuth.signInWithEmailAndPassword(
          email: emailLog, password: passLog);
    } catch (e) {
      print('error');
    }
  }
}
