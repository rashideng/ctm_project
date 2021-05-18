// import 'package:ctm_project/login/login.dart';
import 'package:ctm_project/login/login.dart';
import 'package:ctm_project/login/sign_up.dart';

import 'package:ctm_project/pages/dashboard.dart';
import 'package:ctm_project/pages/dboard.dart';
import 'package:ctm_project/pages/gps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Gps(),
      initialRoute: Dboard.idscreen,
      routes: {
        SignUp.idScreen: (context) => SignUp(),
        HomePage.idScreen: (context) => HomePage(),
        DashBoard.idScreen: (context) => DashBoard(),
        Gps.idScreen: (context) => Gps(),
        Dboard.idscreen: (context) => Dboard(),
      },
    );
  }
}
