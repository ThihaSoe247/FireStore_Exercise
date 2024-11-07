import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_data/Screens/add_human.dart';
import 'package:human_data/constants.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  static String screenId = "LogIn";

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    late String email;
    late String password;

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
              final user = await _auth.signInWithEmailAndPassword(
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
