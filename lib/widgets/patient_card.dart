import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientCard extends StatelessWidget {
  Patient patient;
  PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            '${patient.name} ${patient.surname}',
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(patient.diagnosis.toString()),
        ),
      ),
    );
  }
}
