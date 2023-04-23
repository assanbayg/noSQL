import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';
import '../widgets/doctor_card.dart';
import '../models/doctor.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Doctor> doctors = [];

  Future<void> loadDoctors() async {
    String data = await rootBundle.loadString('database/doctors.json');
    dynamic jsonResult = json.decode(data);
    doctors = (jsonResult['doctors'] as List).map((d) {
      return Doctor(
        id: d['id'],
        name: d['name'],
        surname: d['surname'],
        gender: d['gender'],
        workExperience: d['workExperience'],
        appointments: (d['appointments'] as List)
            .map(
              (ap) => Appointment(
                id: ap['id'],
                patientName: ap['patient'],
                doctorName: ap['patient'],
              ),
            )
            .toList(),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadDoctors().then((_) {
      setState(() {}); // rebuild the widget with the loaded patients data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctors',
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
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              return DoctorCard(doctor: doctors[index]);
            },
          ),
        ),
      ),
    );
  }
}
