import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/pages/homepage.dart';

class TodoController extends GetxController {
  final _firebase = FirebaseFirestore.instance;
  final time = Timestamp.now();

  void addToDo() async {
    try {
      await _firebase.collection('tasks').add({
        'title': titileController.text,
        'description': descController.text,
        'created': time.toString()
      });
    } catch (e) {}
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodos() {
    return _firebase.collection('tasks').snapshots();
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
