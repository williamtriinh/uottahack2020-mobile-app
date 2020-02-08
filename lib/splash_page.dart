import "package:flutter/material.dart";

import "package:firebase_auth/firebase_auth.dart";

import "package:app/routes.dart";

class _SplashPage extends State<SplashPage>
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _checkForLogin() async
  {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user != null)
    {
      // Send to home page
      Navigator.popAndPushNamed(context, homePage);
    }
    else
    {
      // Send to registration screen
      Navigator.popAndPushNamed(context, loginPage);
    }
  }

  @override
  initState()
  {
    super.initState();
    _checkForLogin();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container();
  }
}

class SplashPage extends StatefulWidget
{
  @override
  _SplashPage createState() => _SplashPage();
}