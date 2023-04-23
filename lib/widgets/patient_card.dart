import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/patient.dart';

class PatientCard extends StatefulWidget {
  Patient patient;
  PatientCard({super.key, required this.patient});

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  final TextEditingController _ageTextEditingController =
      TextEditingController();

  void _deletePatient() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/database';
    final file = File(path);

    final String data = await rootBundle.loadString('database/patients.json');
    final jsonResult = json.decode(data);
    List<dynamic> patients = jsonResult['patients'];
    int index = patients.indexWhere((p) => p['id'] == widget.patient.id);
    patients.removeAt(index);
    final updatedPatients = {'patients': patients};
    final updatedJson = json.encode(updatedPatients);
    file.writeAsStringSync(updatedJson);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(updatedJson)));
  }

  void _editAge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'EDIT AGE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextField(
                    controller: _ageTextEditingController,
                  ),
                  TextButton(
                    onPressed: () async {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final path = '${directory.path}/database';
                      final file = File(path);

                      final String data =
                          await rootBundle.loadString('database/patients.json');
                      final jsonResult = json.decode(data);
                      List<dynamic> patients = jsonResult['patients'];
                      int index = patients
                          .indexWhere((p) => p['id'] == widget.patient.id);
                      patients[index].age =
                          int.parse(_ageTextEditingController.text);
                      final updatedPatients = {'patients': patients};
                      final updatedJson = json.encode(updatedPatients);
                      file.writeAsStringSync(updatedJson);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(updatedJson)));
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.person),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.patient.name} ${widget.patient.surname}',
                ),
                Text(
                  widget.patient.diagnosis.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _editAge,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deletePatient,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
