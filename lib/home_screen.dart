import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/firebase_services.dart';
import 'package:firebase_crud/user_form_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? usersDetails;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    usersDetails = await FirebaseServices.getAllUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'User Detail',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BottomSheetScreen()));
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Column(
          children: [
            allUsers(),
          ],
        ),
      ),
    );
  }

  Widget allUsers() {
    return StreamBuilder(
        stream: usersDetails,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot item = snapshot.data.docs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['Name'],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  item['PhoneNumber'],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  item['Email'],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          nameController.text = item['Name'];
                                          phoneController.text = item['PhoneNumber'];
                                          emailController.text = item['Email'];
                                          editUserDetail(item['Id']);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseServices.deleteData(item['Id']);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(child: const Center(child: Text("No data found.")));
        });
  }

  Future editUserDetail(String id) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit details'),
          icon: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel_outlined)),
          content: Container(
            height: 500,
            width: MediaQuery.sizeOf(context).width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Email Id',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> updateInfo ={
                          'Id': id,
                          'Name' : nameController.text.toString(),
                          'PhoneNumber': phoneController.text.toString(),
                          'Email': emailController.text.toString(),
                        };
                        FirebaseServices.updateUserDetail(id, updateInfo).then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("update data successfully")));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
