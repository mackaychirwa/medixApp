import 'dart:convert';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  Appointment({
    required this.id,
    required this.specialist,
    required this.specialistDate,
    required this.doctorName,
    required this.rating,
  });

  String id;
  String specialist;
  DateTime specialistDate;
  String doctorName;
  String rating;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    specialist: json["specialist"],
    specialistDate: DateTime.parse(json["specialist_date"]),
    doctorName: json["doctor_name"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "specialist": specialist,
    "specialist_date": "${specialistDate.year.toString().padLeft(4, '0')}-${specialistDate.month.toString().padLeft(2, '0')}-${specialistDate.day.toString().padLeft(2, '0')}",
    "doctor_name": doctorName,
    "rating": rating,
  };
}
