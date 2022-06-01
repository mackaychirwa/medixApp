import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/classes/api/api.dart';
import 'package:untitled/models/patients.dart';

import '../../models/appointment_model.dart';
import '../../models/chatmodel.dart';
import '../../models/prescription_model.dart';
import '../../models/userdata.dart';


Future<List<Patients>> fetchPatients() async {
  String uri = Api().dataApi;
  final response = await http.get(Uri.parse(uri));
  return patientsFromJson(response.body);
}
Future Appoint(String doctor) async {
  String uri = Api().searchApi;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _user_id = (prefs.getString('user_id') ?? '');
  Map mapData = {
    'doctor_name': doctor,
  };
  print("Data: ${mapData}");
  http.Response response = await http.post(Uri.parse(uri), body: mapData);
  var jsonData =  json.encode(response.body);
  print("DATA: ${jsonData}");

}
Future<List<UserData>> fetchUserData() async {
  String uri = Api().userdataApi;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _user_id = (prefs.getString('user_id') ?? '');
  Map mapData = {
    'user_id': _user_id
  };
  http.Response response = await http.post(Uri.parse(uri), body: mapData);
  return userDataFromJson(response.body);
}

Future<List<Appointment>> fetchAppointment() async {
  String uri = Api().searchApi;
  final response = await http.get(Uri.parse(uri));
  return appointmentFromJson(response.body);
}

Future<List<ChatSelect>?> fetchMessage() async {
  String uri = Api().userchatApi;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _user_id = (prefs.getString('user_id') ?? '');
  Map mapData = {
    'from_user': _user_id
  };
  http.Response response = await http.post(Uri.parse(uri), body: mapData);
  // print(response.body.toString());
  return chatSelectFromJson(response.body);
}

Future<List<Prescriptions>?> fetchDosage() async {
   String uri = Api().dosageApi;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String _user_id = (prefs.getString('user_id') ?? '');
   Map mapData = {
     'user_id': _user_id
   };
   http.Response response = await http.post(Uri.parse(uri), body: mapData);
   return prescriptionsFromJson(response.body);
}

Future<String> fetchData(String uri)  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _user_id = (prefs.getString('user_id') ?? '');
  Map mapData = {
    'user_id': _user_id
  };
  http.Response response = await http.post(Uri.parse(uri), body: mapData);
  return  response.body;
}

Future ChatSend(String chat) async {
  String uri = Api().addchatApi;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _user_id = (prefs.getString('user_id') ?? '');
  Map mapData = {
    'from_user': _user_id,
    'to_user':"2",
    'message_text': chat
  };
  http.Response response = await http.post(Uri.parse(uri), body: mapData);
  var data = json.encode(response.body);
  print("DATA: ${data}");
}

