import 'dart:collection';
import "package:flutter/material.dart";

import "package:flutter/foundation.dart";
import "package:provider/provider.dart";


import "package:app/models/medication/medication.dart";
import "package:app/widgets/medication_widget.dart";

class MedicationModel
{
  static final List<Medication> medications = [];
  static Widget renderList()
  {
    List<Widget> widgets = [];
    medications.forEach((Medication med) {
      widgets.add(new MedicationWidget(medication: med));
    });

    return Column(children: widgets);
  }
}