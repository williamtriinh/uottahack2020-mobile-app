import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

import "package:provider/provider.dart";
import "package:app/routes.dart";
import "package:app/models/medication/medication.dart";
import 'package:app/models/medication/medication_model.dart';
import "package:app/widgets/container_button.dart" as app;
import "package:app/widgets/outline_button.dart" as app;
import 'package:app/home_page.dart';

class _MedicationPage extends State<MedicationPage>
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  final TextEditingController _textMedicationEditingController = new TextEditingController();
  final TextEditingController _textHourEditingController = new TextEditingController();
  final TextEditingController _textMinEditingController = new TextEditingController();

  void _addMedication() async
  {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user != null)
    {

      DocumentSnapshot medInfoRef = await _firestore.collection("medication_info").document("Tetracycline").get();
      Map<String, dynamic> medInfoRefMap = medInfoRef.data;

      DocumentSnapshot ref = await _firestore.collection("users")
        .document(user.uid).get();

      if (ref != null)
      {
        List<dynamic> list = ref.data["medications"]??[];
        list.add(
          {
            "desc": medInfoRefMap["description"],
            "name": medInfoRefMap["name"],
            "times": [{
              "time": "${_textHourEditingController.text}:${_textMinEditingController.text}"
            }]
          }
        );
        await _firestore.collection("users")
          .document(user.uid).updateData(
          {
            "medications": list,
          }
        );

      }

      // Make http reqeust to notification messaging app
      Map<String, dynamic> _body = new Map();
      _body["id"] = user.uid.toString();
      _body["drug"] = medInfoRefMap["name"].toString();
      _body["token"] = ref.data["messagingToken"].toString();
      _body["time"] = "${_textHourEditingController.text}:${_textMinEditingController.text}";
      final _body2 = JsonCodec().encode(_body);
      final http.Response response = await http.post("http://10.197.8.164:8000/add_drug/", headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: _body2 );
      print("[RESPONSE] ${response}");
      if (response.statusCode == 200)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      } else {
        print("Error http: ${response.body}");
      }
      
    }
    else
    {
      // Logout
      await _firebaseAuth.signOut();
      Navigator.popAndPushNamed(context, loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textMedicationEditingController,
              decoration: InputDecoration(
                hintText: "Enter your medication"
              ),
            ),

            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: TextField(
                    controller: _textHourEditingController,
                    decoration: InputDecoration(
                      hintText: "HH"
                    ),
                  ),
                ),

                Container(
                  width: 50,
                  child: TextField(
                    controller: _textMinEditingController,
                    decoration: InputDecoration(
                      hintText: "mm"
                    ),
                  ),
                ),
              ]
            ),

            app.ContainerButton(
              label: "Add",
              onPressed: _addMedication,
            ),
            app.OutlineButton(
              label: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
      )
    );
  }
}

class MedicationPage extends StatefulWidget
{
  _MedicationPage createState() => _MedicationPage();
}