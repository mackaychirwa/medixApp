import 'dart:convert';

List<Prescriptions> prescriptionsFromJson(String str) => List<Prescriptions>.from(json.decode(str).map((x) => Prescriptions.fromJson(x)));

String prescriptionsToJson(List<Prescriptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prescriptions {
  Prescriptions({
    required this.prescriptionId,
    required this.userId,
    required this.prescriptionName,
    required this.prescriptionDosage,
    required this.prescriptionDetail,
    required this.prescriptionStrength,
    required this.prescriptionStartDate,
    required this.prescriptionEndDate,
  });

  String prescriptionId;
  String userId;
  String prescriptionName;
  String prescriptionDosage;
  String prescriptionDetail;
  String prescriptionStrength;
  DateTime prescriptionStartDate;
  DateTime prescriptionEndDate;

  factory Prescriptions.fromJson(Map<String, dynamic> json) => Prescriptions(
    prescriptionId: json["prescription_id"],
    userId: json["user_id"],
    prescriptionName: json["prescription_name"],
    prescriptionDosage: json["prescription_dosage"],
    prescriptionDetail: json["prescription_detail"],
    prescriptionStrength: json["prescription_strength"],
    prescriptionStartDate: DateTime.parse(json["prescription_startDate"]),
    prescriptionEndDate: DateTime.parse(json["prescription_endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "prescription_id": prescriptionId,
    "user_id": userId,
    "prescription_name": prescriptionName,
    "prescription_dosage": prescriptionDosage,
    "prescription_detail": prescriptionDetail,
    "prescription_strength": prescriptionStrength,
    "prescription_startDate": prescriptionStartDate.toIso8601String(),
    "prescription_endDate": prescriptionEndDate.toIso8601String(),
  };
}
