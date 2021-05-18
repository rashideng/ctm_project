import 'package:ctm_project/login/sign_up.dart';
import 'package:ctm_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class HomePage extends StatelessWidget {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  static const String idScreen = "Login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // color: Color(0xFF4A4A58),
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
                      "Log in",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF4A4A58),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18),
                            labelText: 'Email',
                            hintText: 'Enter valid email id as abc@gmail.com'),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid email id"),
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4A4A58),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be atleast 6 characters"),
                          MaxLengthValidator(15,
                              errorText:
                                  "Password should not be greater than 15 characters")
                        ],
                      ),
                      //validatePassword,        //Function to check validation
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Text(
                            "Forget Password",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15),
                          )),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email is not valid", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Password provide password", context);
                        } else {
                          loginAndAuthenticateUser(context);
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
                          constraints:
                              BoxConstraints(maxWidth: 250.0, minHeight: 40.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Log in",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Dnon't have an account ?",
                          style: TextStyle(fontSize: 18, color: Colors.white54),
                        ),
                        Text(
                          "Sign Up",
                          style:
                              TextStyle(color: Colors.blue[300], fontSize: 18),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignUp.idScreen, (route) => false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  loginAndAuthenticateUser(BuildContext context) async {
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

      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.idScreen, (route) => false);
          displayToastMessage("You are LOgged in", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage(
              "You Don't have an account.Please create a new account", context);
        }
      });
    } else {
      displayToastMessage("Error Occured, can not be signed in ", context);
      //error occured
    }
  }
}
