import 'package:no_sql/models/appointment.dart';

enum Diagnosis {
  type1,
  type2,
  gestational,
  none,
}

class Patient {
  int id;
  String name;
  String surname;
  int age;
  String gender;
  String diagnosis;
  bool covid;
  List<Appointment> appointments = [];

  Patient({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
    required this.covid,
    required this.diagnosis,
    required this.appointments,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      age: json['age'],
      gender: json['gender'],
      covid: json['covid'],
      diagnosis: json['diagnosis'],
      appointments: (json['appointments'] as List)
          .map(
            (ap) => Appointment(
              id: ap['id'],
              patientName: '${json['name']} ${json['surname']}',
              doctorName: ap['doctor'],
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> appointmentsList = appointments
        .map((ap) => {
              'id': ap.id,
              'patient': ap.patientName,
              'doctor': ap.doctorName,
            })
        .toList();

    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'gender': gender,
      'covid': covid,
      'diagnosis': diagnosis,
      'appointments': appointmentsList,
    };
  }
}
