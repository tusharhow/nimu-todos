import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nimu_todos/pages/homepage.dart';

class TodoController extends GetxController {
  Future<void> addTaskToFirebase(final text) async {
    String uid = auth.currentUser!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(uid)
        .set({
      'id': uid,
      'title': titileController.text,
      'description': descController.text,
      'time': time.toString(),
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }
}