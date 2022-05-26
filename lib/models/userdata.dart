import 'dart:convert';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  UserData({
    required this.id,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.status,
    required this.tPin,
    required this.location,
    required this.loginTime,
    required this.logoutTime,
    required this.hospitalName,
    required this.db,
    required this.regDate,
  });

  String id;
  String email;
  String password;
  String phone;
  String role;
  String status;
  String tPin;
  String location;
  DateTime loginTime;
  dynamic logoutTime;
  String hospitalName;
  String db;
  DateTime regDate;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    role: json["role"],
    status: json["status"],
    tPin: json["t_pin"],
    location: json["location"],
    loginTime: DateTime.parse(json["login_time"]),
    logoutTime: json["logout_time"],
    hospitalName: json["hospital_name"],
    db: json["db"],
    regDate: DateTime.parse(json["reg_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "phone": phone,
    "role": role,
    "status": status,
    "t_pin": tPin,
    "location": location,
    "login_time": loginTime.toIso8601String(),
    "logout_time": logoutTime,
    "hospital_name": hospitalName,
    "db": db,
    "reg_date": regDate.toIso8601String(),
  };
}
