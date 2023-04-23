import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:no_sql/screens/create_patient.dart';
import '../models/patient.dart';
import '../widgets/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  List<Patient> patients = [];

  //fetch content from patients.json
  Future<void> loadPatients() async {
    final String data = await rootBundle.loadString('database/patients.json');
    final jsonResult = json.decode(data);
    setState(() {
      patients = (jsonResult['patients'] as List)
          .map((p) => Patient.fromJson(p))
          .toList();
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePatientScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
