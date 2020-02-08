import 'package:app/models/medication/medication_model.dart';
import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "package:provider/provider.dart";

import "package:app/routes.dart";
import "package:app/widgets/add_medicaiton_modal.dart";
import "package:app/widgets/container_button.dart" as app;

class _HomePage extends State<HomePage>
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Widget modal = new Container(width: 0, height: 0);

  void _openMedicationModal()
  {
    if (modal is Container)
    {
      setState(() {
        modal = new AddMedicationModal(
          addData: _addMedication,
          closeModal: _closeModal
        );
      });
    }
  }

  void _goToMyMedications(BuildContext context)
  {
    Navigator.pushNamed(context, medicationPage);
  }

  void _signOut(BuildContext context) async
  {
    await _firebaseAuth.signOut();
  }

  void _addMedication() async
  {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user != null)
    {
      print("good");
      // _firestore.collection("medications").document(user.uid);
    }
    else
    {
      // Logout
      await _firebaseAuth.signOut();
      Navigator.popAndPushNamed(context, loginPage);
    }
  }

  void _closeModal()
  {
    setState(() {
      modal = new Container(width: 0, height: 0);
    });
  }

  @override
  initState()
  {
    super.initState();
    _firebaseAuth.onAuthStateChanged.listen((FirebaseUser user) {
      if (user == null)
      {
        Navigator.popAndPushNamed(context, loginPage);
      }
    });
    _firebaseMessaging.configure(
      onResume: (Map<String, dynamic> message) async {
        print("onResume");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[

                app.ContainerButton(
                  label: "My medications",
                  onPressed: () {
                    print("good");
                    _goToMyMedications(context);
                  }
                ),

                Spacer(),
                
                app.ContainerButton(
                  label: "Sign out",
                  onPressed: () {
                    _signOut(context);
                  }
                )
              ]
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(right: 36.0, bottom: 36.0),
                child: FloatingActionButton(
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 24.0
                    )
                  ),
                  onPressed: () {
                    _openMedicationModal();
                  },
                )
              )
            ),
            modal
          ]
        )
      )
    );
  }
  
}

class HomePage extends StatefulWidget
{
  @override
  _HomePage createState() => _HomePage();
}