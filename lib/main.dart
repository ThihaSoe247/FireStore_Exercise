import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:human_data/Screens/add_human.dart';
import 'package:human_data/Screens/data_screen.dart';
import 'package:human_data/Screens/welcome.dart';

import 'Screens/Log_in.dart';
import 'Screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Firebase initialized successfully");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Welcome(),
        routes:{
          LogInScreen.screenId:(context) => LogInScreen(),
          RegisterScreen.screenId:(context) => RegisterScreen(),
          Human.screenId: (context) => Human(),
          HumanStream.screenId: (context) => HumanStream(),
        }
    );
  }
}