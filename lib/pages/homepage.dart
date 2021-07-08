import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/todo_controller.dart';
import 'package:nimu_todos/pages/drawer.dart';
import 'package:nimu_todos/pages/floating_button.dart';

final titileController = TextEditingController();
final descController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoController = Get.put(TodoController(), permanent: true);

  String uid = '';

  @override
  void initState() {
    super.initState();

    getUid();
  }

  getUid() async {
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
        stream: todoController.getTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data!.docs[index];
              return Dismissible(
                key: Key(item.data().toString()),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Text(
                          '${item['title']}',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Text(
                        //   '${item['description']}',
                        //   style: TextStyle(
                        //       fontSize: 17,
                        //       fontWeight: FontWeight.w700,
                        //       color: Colors.black38),
                        // ),
                      ],
                    ),
                    // child: ListTile(
                    //     title: Text(
                    //       '${item['title']}',
                    //       style: TextStyle(
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.w700,
                    //           color: Colors.white),
                    //     ),
                    //     tileColor: Colors.teal,
                    //     subtitle: Text(
                    //       '${item['description']}',
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w400,
                    //           color: Colors.white60),
                    //       softWrap: true,
                    //     ),
                    //     trailing: IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.delete,
                    //         color: Colors.white70,
                    //       ),
                    //     )),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingButton(todoController: todoController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: DrawerHome(),
    );
  }
}
