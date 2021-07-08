import 'package:cloud_firestore/cloud_firestore.dart';
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
  String uid = '';

  @override
  void initState() {
    super.initState();

    getUid();
  }

  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Nimu TODOS'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            var docs = snapshot.data!.docs;
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(docs[index]['title']),
                          subtitle: Text(docs[index]['description']),
                        ),
                      ),
                    ],
                    // children: [Text(snapshot.data!.docs[0]['title'])],
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white,
              actions: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: titileController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'TODO Title',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: descController,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    labelText: 'TODO Description',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  try {
                                    todoController.addTaskToFirebase(context);
                                  } catch (e) {
                                    Get.snackbar(
                                        'Error while adding TODOS', '');
                                  }
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Add TODO',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
