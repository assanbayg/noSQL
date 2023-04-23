import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/patient.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({super.key});

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _surnameEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();

  String _gender = 'male';
  bool _covid = false;
  Diagnosis _diagnosis = Diagnosis.none;

  void createPatient(Patient patient) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/database';
    final file = File(path);

    final String data = await rootBundle.loadString('database/patients.json');
    final jsonResult = json.decode(data);
    List<Patient> patients = (jsonResult['patients'] as List)
        .map((p) => Patient.fromJson(p))
        .toList();
    patients.add(patient);
    final String updatedJson =
        jsonEncode(patients.map((entry) => entry.toJson()).toList());
    file.writeAsStringSync(updatedJson);
    ScaffoldMessenger.of(context) //shows updated JSON filek
        .showSnackBar(SnackBar(content: Text(updatedJson)));
    print(updatedJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Patient',
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
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: _surnameEditingController,
                  decoration: const InputDecoration(hintText: 'Surname'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Gender'),
                    DropdownButton(
                        value: _gender,
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'female', child: Text('Female')),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _gender = val as String;
                          });
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Covid'),
                    Checkbox(
                      value: _covid,
                      onChanged: (val) => setState(() => _covid = val as bool),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Diagnosis'),
                    DropdownButton(
                        value: _diagnosis,
                        items: const [
                          DropdownMenuItem(
                              value: Diagnosis.type1, child: Text('Type 1')),
                          DropdownMenuItem(
                              value: Diagnosis.type2, child: Text('Type 2')),
                          DropdownMenuItem(
                              value: Diagnosis.gestational,
                              child: Text('Gestational')),
                          DropdownMenuItem(
                              value: Diagnosis.none, child: Text('None')),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _diagnosis = val as Diagnosis;
                          });
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Age'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _ageTextEditingController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (_ageTextEditingController.text == '') {
                  return;
                }
                final Patient patient = Patient(
                  name: _nameEditingController.text,
                  surname: _surnameEditingController.text,
                  gender: _gender.toString(),
                  age: int.parse(_ageTextEditingController.text),
                  covid: _covid,
                  diagnosis: _diagnosis.name.toString(),
                  id: Random().nextInt(10000000),
                  appointments: [],
                );

                createPatient(patient);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
