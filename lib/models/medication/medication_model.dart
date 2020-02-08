import 'dart:collection';
import "package:flutter/material.dart";

import "package:flutter/foundation.dart";
import "package:provider/provider.dart";


import "package:app/models/medication/medication.dart";
import "package:app/widgets/medication_item.dart";

class MedicationModel extends ChangeNotifier
{
  final List<Medication> _medications = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Medication> get medications => UnmodifiableListView(_medications);

  void addMedication(Medication medication)
  {
    _medications.add(medication);
    notifyListeners();
  }

  Column renderList()
  {
    List<MedicationItem> items = [];
    _medications.forEach((med) {
      items.add(new MedicationItem(medication: med));
    });

    return new Column(children: items);
  }
  
}