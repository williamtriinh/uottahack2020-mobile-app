import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "package:app/routes.dart";
import "package:app/widgets/container_button.dart" as app;

class SignupPage extends StatelessWidget
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  final TextEditingController _textFieldEmailController = new TextEditingController();
  final TextEditingController _textFieldPasswordController = new TextEditingController();
  final TextEditingController _textFieldConfirmPasswordController = new TextEditingController();

  void _signupWithEmailAndPassword(BuildContext context) async
  {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: "william.t2039@gmail.com",
        password: "Google123456"
      );

      if (result.user != null)
      {
        FirebaseUser user = result.user;

        print("stuff");

        // Create firestore document
        Firestore firestore = Firestore.instance;
        await firestore.collection("users").document(user.uid).setData(
          {
            "name": "William Trinh",
            "messagingToken": await _firebaseMessaging.getToken()
          }
        );

        print("he");

        Navigator.popAndPushNamed(context, homePage);
      }
    }
    catch(error)
    {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              "Signup",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
              ),
              controller: _textFieldEmailController
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
              controller: _textFieldPasswordController,
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Confirm password",
              ),
              controller: _textFieldConfirmPasswordController,
              obscureText: true,
            ),
            app.ContainerButton(
              label: "Signup",
              onPressed: () {
                _signupWithEmailAndPassword(context);
              },
            ),

            Spacer(),

            app.ContainerButton(
              label: "Already have an account? Login",
              onPressed: () { Navigator.pop(context); }
            )
          ],
        )
      )
    );
    // return Scaffold(
    //   body: Column(
    //         children: <Widget>[
    //           
    //           TextField(
    //             controller: _textFieldEmailController
    //           ),
    //           TextField(
    //             controller: _textFieldPasswordController,
    //             obscureText: true
    //           ),
    //           app.ContainerButton(
    //             onPressed: null,
    //           )
    //         ],
    //       ),
    // );
  }
}