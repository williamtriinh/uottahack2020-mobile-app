import "package:flutter/material.dart";

import "package:app/models/medication/medication.dart";

class MedicationItem extends StatelessWidget
{
  MedicationItem({@required this.medication});
  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            "Some title",
          )
        ],
      )
    );
  }
  
}