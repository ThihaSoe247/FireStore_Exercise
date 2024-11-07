import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_data/Screens/register_screen.dart';

import 'Log_in.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to the App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LogInScreen.screenId);
              },
              child: Text("Log In")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.screenId);
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
