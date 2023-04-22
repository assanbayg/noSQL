import 'package:no_sql/models/appointment.dart';

enum Diagnosis {
  type1,
  type2,
  gestational,
}

class Patient {
  int id;
  String name;
  String surname;
  int age;
  DateTime dateOfBirth;
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
