import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nimu_todos/pages/about_dev.dart';
import 'package:get/get.dart';
import 'package:nimu_todos/controllers/todo_controller.dart';
import 'package:nimu_todos/pages/login.dart';

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
                child: Card(
                  child: ListTile(
                      title: Text('${item['title']}'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
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
                                onTap: () async {
                                  try {
                                    todoController.addToDo();
                                    Navigator.pop(context);
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: DrawerHeader(
                child: CircleAvatar(
                  child: Text(
                    "Your Daily TODO Manager",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Galada'),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.more),
              onTap: () {
                Get.to(() => AboutDev());
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                "Rate Our Apps",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontFamily: 'Galada',
                    fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.sentiment_very_satisfied,
                  size: 23, color: Colors.teal),
            )
          ],
        ),
      ),
    );
  }
}
