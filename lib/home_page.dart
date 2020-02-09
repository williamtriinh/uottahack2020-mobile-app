import 'dart:convert';

import 'package:app/models/medication/medication_model.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:app/widgets/medication_widget.dart';
import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:app/models/medication/medication.dart";
import 'package:flutter/services.dart';

import "package:provider/provider.dart";

import "package:app/routes.dart";
import "package:app/widgets/add_medicaiton_modal.dart";
import "package:app/widgets/container_button.dart" as app;

class _HomePage extends State<HomePage>
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Widget test = Container();
  String displayName = "";

  void _openMedicationPage()
  {
    Navigator.pushNamed(context, medicationPage);
  }

  // void _goToMyMedications(BuildContext context)
  // {
  //   Navigator.pushNamed(context, medicationPage);
  // }

  void _signOut(BuildContext context) async
  {
    await _firebaseAuth.signOut();
  }

  void _loadMedications() async
  {
    MedicationModel.medications.clear();

    FirebaseUser user = await _firebaseAuth.currentUser();

    if (user != null)
    {
      // Read the documents
      
      DocumentSnapshot snapshot = await _firestore.collection("users").document(user.uid).get();

      // Store name
      UserModel.fullName = snapshot["name"];
      setState(() {
        displayName = UserModel.fullName;
      });

      List<dynamic> list = snapshot.data["medications"]??[];

      for (int i=0; i<list.length; i++)
      {
        Map<dynamic, dynamic> obj = snapshot.data["medications"][i];
        MedicationModel.medications.add(
          new Medication(
            name: obj["name"],
            description: obj["desc"],
            time: obj["times"][0]["time"]
          )
        );
      }

      setState(() {
        test = MedicationModel.renderList();
      });
      
      
    }
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
    _loadMedications();
    _firebaseMessaging.configure(
      onResume: (Map<String, dynamic> message) async {
        print("onResume");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { return false; },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(36.0),
                      child: Text(
                        "Welcome back,\n${displayName}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                        )
                      ),
                    ),
                    test
                  ],
                )
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 36.0, right: 36.0),
                  child: app.ContainerButton(
                    label: "Sign out",
                    onPressed: () {
                      _signOut(context);
                    }
                  )
                )
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
                      _openMedicationPage();
                      // _loadMedications();
                    },
                  )
                )
              ),
            ]
          )
        
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