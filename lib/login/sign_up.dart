import 'package:ctm_project/login/login.dart';
import 'package:ctm_project/main.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUp(),
      ),
    );

class SignUp extends StatelessWidget {
  static const String idScreen = "SignUp";

  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xFF4A4A58),
                Colors.black87,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SignUp",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              controller: nameTextEditingController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF4A4A58),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  labelText: 'Full Name',
                                  hintText: 'Enter your Full Name'),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                                controller: emailTextEditingController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF4A4A58),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    labelText: 'Email',
                                    hintText:
                                        'Enter valid email id as abc@gmail.com'),
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  EmailValidator(
                                      errorText: "Enter valid email id"),
                                ])),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                                controller: passwordTextEditingController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF4A4A58),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    labelText: 'Password',
                                    hintText: 'Enter secure password'),
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  MinLengthValidator(6,
                                      errorText:
                                          "Password should be atleast 6 characters"),
                                  MaxLengthValidator(15,
                                      errorText:
                                          "Password should not be greater than 15 characters")
                                ])
                                //validatePassword,        //Function to check validation
                                ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 50.0,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () {
                                if (nameTextEditingController.text.length < 6) {
                                  displayToastMessage(
                                      "Name Must Be 5 Character", context);
                                } else if (!emailTextEditingController.text
                                    .contains("@")) {
                                  displayToastMessage(
                                      "Email is not valid", context);
                                } else if (passwordTextEditingController
                                        .text.length <
                                    7) {
                                  displayToastMessage(
                                      "Password must contain 8 latters",
                                      context);
                                } else {
                                  registerNewUser(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF4A4A58),
                                        Color(0xFF4A4A58),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 250.0, minHeight: 40.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SignUp",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Already have an account ?",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white54),
                                ),
                                Text(
                                  "log in",
                                  style: TextStyle(
                                      color: Colors.blue[300], fontSize: 18),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomePage.idScreen, (route) => false);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      //save user info to Database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congratulations", context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.idScreen, (route) => false);
    } else {
      displayToastMessage("User account has not be created ", context);
      //error occured
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
