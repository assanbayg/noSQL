import 'package:intl/intl.dart';
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
  String dateOfBirth;
  String gender;
  String diagnosis;
  bool covid;
  List<GlucoseLevel> glucoseLevels = [];
  List<Appointment> appointments = [];

  Patient({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.covid,
    required this.diagnosis,
    required this.glucoseLevels,
    required this.appointments,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      age: json['age'],
      dateOfBirth:
          DateFormat('dd/MM/yyyy').parse(json['dateOfBirth']).toString(),
      gender: json['gender'],
      covid: json['covid'],
      diagnosis: json['diagnosis'],
      glucoseLevels: (json['glucoseLevels'] as List).map(
        (level) {
          return GlucoseLevel(
            date: DateFormat('dd/mm/yyyy').parse(level['date']),
            time: DateFormat('HH:mm').parse(level['time']),
            level: level['level'],
          );
        },
      ).toList(),
      appointments: (json['appointments'] as List)
          .map(
            (ap) => Appointment(
              id: ap['id'],
              date: DateFormat('dd/mm/yyyy').parse(ap['date']),
              time: DateFormat('HH:mm').parse(ap['time']),
              patientName: '${json['name']} ${json['surname']}',
              doctorName: ap['doctor'],
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> glucoseLevelsList = glucoseLevels
        .map((gl) => {
              'date': gl.date.toIso8601String(),
              'time': gl.time.toIso8601String(),
              'level': gl.level,
            })
        .toList();
    List<Map<String, dynamic>> appointmentsList = appointments
        .map((ap) => {
              'id': ap.id,
              'date': ap.date.toIso8601String(),
              'time': ap.time.toIso8601String(),
              'patient': ap.patientName,
              'doctor': ap.doctorName,
            })
        .toList();

    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'covid': covid,
      'diagnosis': diagnosis,
      'glucoseLevels': glucoseLevelsList,
      'appointments': appointmentsList,
    };
  }
}

class GlucoseLevel {
  DateTime date;
  DateTime time;
  double level;

  GlucoseLevel({
    required this.date,
    required this.time,
    required this.level,
  });
}
