import 'package:flutter/material.dart';

class Id with ChangeNotifier {
  int patientId = 2;
  int doctorId = 1;
  int appointmentId = 3;

  int nextPatientId() {
    patientId++;
    notifyListeners();
    return patientId;
  }
}
