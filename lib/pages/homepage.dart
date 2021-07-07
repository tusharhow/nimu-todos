import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/todo_controller.dart';

final titileController = TextEditingController();
final descController = TextEditingController();
final todoController = Get.put(TodoController());
final FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nimu TODOS'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: titileController,
                    decoration: InputDecoration(hintText: 'Titile'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              todoController.addTaskToFirebase();
            },
            child: Text('Add TODO'),
          ),
        ],
      ),
    );
  }
}
