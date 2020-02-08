import "package:flutter/material.dart";

import "package:provider/provider.dart";

import "package:app/models/medication/medication.dart";
import 'package:app/models/medication/medication_model.dart';

class MedicationPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container()
        // child: Consumer<MedicationModel>(
        //   builder: (BuildContext context, MedicationModel medicationModel, child) {
        //     return medicationModel.renderList();
        //   }
        // )
      )
    );
  }
}