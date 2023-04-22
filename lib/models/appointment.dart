class Appointment {
  int id;
  DateTime date;
  DateTime time;
  String patientName;
  String doctorName;

  Appointment({
    required this.id,
    required this.date,
    required this.time,
    required this.patientName,
    required this.doctorName,
  });
}
