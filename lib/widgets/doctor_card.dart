import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  Doctor doctor;
  DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('${doctor.name} ${doctor.surname}'),
      )),
    );
  }
}
