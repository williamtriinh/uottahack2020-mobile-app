import "package:flutter/material.dart";

import 'package:firebase_auth/firebase_auth.dart';

import "package:app/routes.dart";
import "package:app/widgets/container_button.dart" as app;
import "package:app/widgets/outline_button.dart" as app;

class LoginPage extends StatelessWidget
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _textFieldEmailController = new TextEditingController();
  final TextEditingController _textFieldPasswordController = new TextEditingController();

  void _loginWithEmailAndPassword(BuildContext context) async
  {
    final String _email = _textFieldEmailController.text.toLowerCase();
    final String _password = _textFieldPasswordController.text;

    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password
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
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Align(
                    alignment: Alignment.center,
                    child: Image.asset("lib/assets/logo.png", scale: 2.5)
                  ),

                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900
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

                  Container(height: 36.0),

                  app.ContainerButton(
                    label: "Login",
                    onPressed: () {
                      _loginWithEmailAndPassword(context);
                    },
                  ),
                  
                  app.OutlineButton(
                    label: "Don't have an account? Sign up",
                    onPressed: () {
                      Navigator.pushNamed(context, signupPage);
                    },
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