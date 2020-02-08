import "package:flutter/material.dart";

import 'package:firebase_auth/firebase_auth.dart';

import "package:app/routes.dart";
import "package:app/widgets/container_button.dart" as app;

class LoginPage extends StatelessWidget
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _textFieldEmailController = new TextEditingController();
  final TextEditingController _textFieldPasswordController = new TextEditingController();

  void _loginWithEmailAndPassword(BuildContext context) async
  {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: "william.t2039@gmail.com",
        password: "Google123456"
      );
      
      if (result.user != null)
      {
        Navigator.popAndPushNamed(context, homePage);
      }
    }
    catch (error)
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
              "Login",
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
            app.ContainerButton(
              label: "Login",
              onPressed: () {
                _loginWithEmailAndPassword(context);
              },
            ),

            Spacer(),
            
            app.ContainerButton(
              label: "Don't have an account? Sign up",
              onPressed: () {
                Navigator.pushNamed(context, signupPage);
              },
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