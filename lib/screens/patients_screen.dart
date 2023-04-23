// ignore_for_file: no_leading_underscores_for_local_identifiers

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

  void _showMatchingPatients(List<Patient> filteredOrSortedPatients) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                  itemCount: filteredOrSortedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = filteredOrSortedPatients[index];
                    return ListTile(
                      title: Text(
                          '${patient.name} ${patient.surname} - ${patient.age} years'),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  //sort patients by their age
  void _sortByAge() {
    final sortedPatients = List<Patient>.from(patients)
      ..sort((a, b) => a.age.compareTo(b.age));
    _showMatchingPatients(sortedPatients);
  }

  //filter patients by their name
  void _filterPatients() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final TextEditingController _filterController =
              TextEditingController();
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'FILTER BY NAME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextField(
                    controller: _filterController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final filteredPatients = patients
                          .where((p) => p.name
                              .toLowerCase()
                              .contains(_filterController.text.toLowerCase()))
                          .toList();
                      _showMatchingPatients(filteredPatients);
                    },
                    child: const Text('FILTER'),
                  ),
                ],
              ),
            ),
          );
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
        actions: [
          IconButton(
            //filter patients by their name
            icon: const Icon(Icons.filter_alt),
            onPressed: _filterPatients,
          ),
          IconButton(
            //sort patients by their age
            icon: const Icon(Icons.sort),
            onPressed: _sortByAge,
          ),
        ],
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreatePatientScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
