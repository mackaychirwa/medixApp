import 'dart:convert';

List<Patients> patientsFromJson(String str) => List<Patients>.from(json.decode(str).map((x) => Patients.fromJson(x)));

String patientsToJson(List<Patients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patients {
  Patients({
    required this.id,
    required this.representativeName,
    required this.hospitalName,
    required this.tPin,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.nationalIdNumber,
    required this.otp,
    required this.subscriptionDate,
  });

  String? id;
  String? representativeName;
  String? hospitalName;
  String? tPin;
  String email;
  String? phone;
  String? address;
  String? status;
  String? nationalIdNumber;
  String? otp;
  DateTime? subscriptionDate;

  factory Patients.fromJson(Map<String, dynamic> json) => Patients(
    id: json["id"],
    representativeName: json["representative_name"],
    hospitalName: json["hospital_name"],
    tPin: json["t_pin"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    status: json["status"],
    nationalIdNumber: json["national_id_number"],
    otp: json["otp"],
    subscriptionDate: DateTime.parse(json["subscription_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "representative_name": representativeName,
    "hospital_name": hospitalName,
    "t_pin": tPin,
    "email": email,
    "phone": phone,
    "address": address,
    "status": status,
    "national_id_number": nationalIdNumber,
    "otp": otp,
    "subscription_date": subscriptionDate?.toIso8601String(),
  };
}