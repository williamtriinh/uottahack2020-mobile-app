import 'dart:io';

import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "package:app/routes.dart";
import "package:app/widgets/container_button.dart" as app;
import "package:app/widgets/outline_button.dart" as app;

class SignupPage extends StatelessWidget
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  final TextEditingController _textFieldFullNameController = new TextEditingController();
  final TextEditingController _textFieldEmailController = new TextEditingController();
  final TextEditingController _textFieldPasswordController = new TextEditingController();
  final TextEditingController _textFieldConfirmPasswordController = new TextEditingController();

  void _signupWithEmailAndPassword(BuildContext context) async
  {
    final String _fullName = _textFieldFullNameController.text;
    final String _email = _textFieldEmailController.text;
    final String _password = _textFieldPasswordController.text;
    final String _confirmPassword = _textFieldConfirmPasswordController.text;

    if (_password != _confirmPassword)
    {
      return;
    }

    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email,
        password: _password
      );

      if (result.user != null)
      {
        FirebaseUser user = result.user;

        // Create firestore document
        Firestore firestore = Firestore.instance;
        await firestore.collection("users").document(user.uid).setData(
          {
            "name": _fullName,
            "messagingToken": await _firebaseMessaging.getToken()
          }
        );

        sleep(Duration(seconds: 2));

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
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Full name",
                    ),
                    controller: _textFieldFullNameController
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

                  Container(height: 36.0),

                  app.ContainerButton(
                    label: "Signup",
                    onPressed: () {
                      _signupWithEmailAndPassword(context);
                    },
                  ),

                  app.OutlineButton(
                    label: "Already have an account? Login",
                    onPressed: () { Navigator.pop(context); }
                  )
                ],
              )
            )
          ]
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