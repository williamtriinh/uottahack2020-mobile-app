import 'package:app/models/medication/medication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class _ViewDrugPage extends State<ViewDrugPage>
{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Map<String, dynamic> medicationInfo = {"info": [], "instructions": []};

  void _retrieveMedication() async
  {

    FirebaseUser user = await _firebaseAuth.currentUser();

    if (user != null)
    {
      // Read the documents
      DocumentSnapshot snapshot = await _firestore.collection("medication_info").document(widget.data.name).get();
      setState(() { medicationInfo = snapshot.data; });
    }

  }

  Widget _renderLists(List<dynamic> list)
  {
    List<Widget> widgets = [];
    for (int i=0; i<list.length; i++)
    {
      widgets.add(
        new Text("- ${list[i]}")
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      )
    );
  }

  @override
  initState()
  {
    super.initState();
    _retrieveMedication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(left: 36, right: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Align(
                    child: Image.network("https://d2gdaxkudte5p.cloudfront.net/system/thumbs/system/images/T17000-25.0__1073935741.jpg"),
                    alignment: Alignment.topCenter,
                  ),

                  Text(
                    widget.data.name,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700
                    )
                  ),

                  Container(height: 8),

                  Text(
                    "Medication must be taken at ${widget.data.time}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.amber
                    )
                  ),

                  Container(height: 24),

                  Text(
                    widget.data.description
                  ),

                  _renderLists(medicationInfo["info"]),

                  _renderLists(medicationInfo["instructions"])

                ]
              )
            )
          ]
        )
      )
    );
  }

}

class ViewDrugPage extends StatefulWidget
{
  ViewDrugPage({this.data});
  final Medication data;

  @override
  _ViewDrugPage createState() => _ViewDrugPage();
  
}