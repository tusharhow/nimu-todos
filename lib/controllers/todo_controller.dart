import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';

final _auth = FirebaseAuth.instance;

class TodoController extends GetxController {
  final _firebase = FirebaseFirestore.instance;
  final time = Timestamp.now();
  final uid = _auth.currentUser?.uid;

  void addToDo() async {
    // FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _firebase.collection('tasks').doc(uid).collection('userTasks').add({
        'title': titileController.text,
        'id': uid,
        'description': descController.text,
        'created': time.toString()
      });
      Fluttertoast.showToast(msg: 'Data Added');
    } catch (e) {}
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodos() {
    return _firebase
        .collection('tasks')
        .doc(uid)
        .collection('userTasks')
        .snapshots();
  }

  // Future removeTodo() async {
  //   await _firebase.doc().delete();
  // }

  // Future<void> addTaskToFirebase() async {
  //   String uid = auth.currentUser!.uid;
  //   var time = DateTime.now();
  //   await FirebaseFirestore.instance
  //       .collection('tasks')
  //       .doc()
  //       .collection('mytasks')
  //       .doc()
  //       .set({
  //     'id': uid,
  //     'title': titileController.text,
  //     'description': descController.text,
  //     'time': time.toString(),
  //   });
  //   Fluttertoast.showToast(msg: 'Data Added');
  // }
}
