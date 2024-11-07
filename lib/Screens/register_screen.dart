import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'add_human.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String screenId = "Register";

  @override
  Widget build(BuildContext context) {

    late String email;
    late String password;
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InfoTextField(hintText: "Enter Email", onChanged: (value){
            email = value;
          },),
          SizedBox(height: 20,),
          InfoTextField(hintText: "Password", onChanged: (value){
            password = value;
          },isPassword: true),
          ElevatedButton(onPressed: () async{
            try {
              final user = await _auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              Navigator.pushNamed(context, Human.screenId);
            } catch (e) {
              print("Error is $e");


            }

          },
              child: Text("Log In"))
        ],
      ),
    );
  }
}
