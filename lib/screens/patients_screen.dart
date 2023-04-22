import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/appointment.dart';
import '../widgets/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  List<Patient> patients = [];

  Future<void> loadPatients() async {
    String data = await rootBundle.loadString('database/patients.json');
    dynamic jsonResult = json.decode(data);
    patients = (jsonResult['patients'] as List).map((p) {
      return Patient(
        id: p['id'],
        name: p['name'],
        surname: p['surname'],
        age: p['age'],
        dateOfBirth: DateFormat('dd/mm/yyyy').parse(p['dateOfBirth']),
        gender: p['gender'],
        covid: p['covid'],
        diagnosis: p['diagnosis'],
        glucoseLevels: (p['glucoseLevels'] as List).map(
          (level) {
            return GlucoseLevel(
              date: DateFormat('dd/mm/yyyy').parse(level['date']),
              time: DateFormat('HH:mm').parse(level['time']),
              level: level['level'],
            );
          },
        ).toList(),
        appointments: (p['appointments'] as List)
            .map(
              (ap) => Appointment(
                id: ap['id'],
                date: DateFormat('dd/mm/yyyy').parse(ap['date']),
                time: DateFormat('HH:mm').parse(ap['time']),
                patientName: ap['doctor'],
                doctorName: ap['doctor'],
              ),
            )
            .toList(),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadPatients().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patients',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.025,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) => PatientCard(
              patient: patients[index],
            ),
          ),
        ),
      ),
    );
  }
}
