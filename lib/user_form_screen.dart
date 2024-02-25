import 'dart:math';

import 'package:firebase_crud/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class BottomSheetScreen extends StatelessWidget {
  BottomSheetScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Email Id', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> userInfo ={
                      'Id': id,
                      'Name' : nameController.text.toString(),
                      'PhoneNumber': phoneController.text.toString(),
                      'Email': emailController.text.toString(),
                    };
                    FirebaseServices.addUsersData(userInfo, id).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Add data successfully")));
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Add user', style: TextStyle(color: Colors.black),),),
            ),
          ],
        ),
    ),
    );
  }
}
