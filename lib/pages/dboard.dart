import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ctm_project/pages/CircleProgress.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Dboard extends StatefulWidget {
  static var idscreen;

  @override
  _DboardState createState() => _DboardState();
}

class _DboardState extends State<Dboard> with SingleTickerProviderStateMixin {
  bool isloading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final databaseReference = FirebaseDatabase.instance.reference();

  AnimationController progressController;
  Animation<double> tempAnimation;

  @override
  void initState() {
    super.initState();
    databaseReference.child("ESP_32").once().then((DataSnapshot snapshot) {
      double temp = snapshot.value['Temperature']['Data'];

      isloading = true;
      _DashboardInit(temp);
    });
  }

  // ignore: non_constant_identifier_names
  _DashboardInit(double temp) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    tempAnimation = Tween(begin: -50, end: temp).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: new IconButton(icon: Icon(Icons.reorder), onPressed: () {}),
      ),
      body: Center(
          child: isloading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomPaint(
                      foregroundPainter:
                          CircleProgress(tempAnimation.value, true),
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Center(
                          child: Column(
                            children: [
                              Text("Temperature"),
                              Text(
                                '${tempAnimation.value.toInt()}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "°C",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Text(
                  "Loading...",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
    );
  }
}
