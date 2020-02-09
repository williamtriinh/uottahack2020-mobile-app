import 'package:app/view_drug_page.dart';
import "package:flutter/material.dart";

import "package:app/routes.dart";
import "package:app/models/medication/medication.dart";

class MedicationWidget extends StatelessWidget
{
  MedicationWidget({@required this.medication});
  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top:16, bottom: 32, left: 36, right: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  medication.name,
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
                Spacer(),
                Text(
                  medication.time,
                  textAlign: TextAlign.left,
                  softWrap: true,
                )
              ],
            )
            
          ]
        )
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ViewDrugPage(data: medication)
        ));
      }
    );
  }
  
}