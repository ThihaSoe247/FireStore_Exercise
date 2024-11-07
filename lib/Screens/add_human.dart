import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:human_data/Screens/data_screen.dart';

import '../constants.dart';

class Human extends StatelessWidget {
  static String screenId = "HumanAdd";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String name, String university, String major, String gender) async {
    try {
      String? creatorEmail = _auth.currentUser?.email;
      await _firestore.collection('people').add({
        'Name': name,
        'University': university,
        'Major': major,
        'Creator': creatorEmail,
        'Gender': gender,
        // Include creator's email if logged in
      });
      print("User data saved successfully.");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    String? university;
    String? major;
    String? gender;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add One Human"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoTextField(
                  hintText: "Enter Your Name",
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(height: 20),
                InfoTextField(
                  hintText: "Enter University Name",
                  onChanged: (value) {
                    university = value;
                  },
                ),
                SizedBox(height: 20),
                InfoTextField(
                  hintText: "Enter Your Major",
                  onChanged: (value) {
                    major = value;
                  },
                ),
                SizedBox(height: 20),
                InfoTextField(
                  hintText: "Gender",
                  onChanged: (value) {
                    gender = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (name != null && university != null && major != null && gender!=null) {
                      await saveUserData(name!, university!, major!, gender!);
                    } else {
                      print("Please fill in all fields");
                    }
                  },
                  child: Text("Save Person"),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HumanStream.screenId);
                  },
                  child: Text("See the HUman List"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
