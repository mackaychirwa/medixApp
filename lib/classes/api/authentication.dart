import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/classes/api/api.dart';
import '../../models/userdata.dart';
import '../../widgets/bottom_nav.dart';



Future<UserData?> loginUser(BuildContext context, String id, String email, String password) async {
  var api = Api().login;
  Map mapData = {
    'user_id':id,
    'email': email,
    'password': password
  };
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  http.Response response = await http.post(Uri.parse(api), body: mapData);
  var jsonData =  json.decode(response.body);
  if(jsonData != null)
  {
    // print(jsonData);
    sharedPreferences.setString("user_id", jsonData["data"]["id"]);
    print(sharedPreferences.getString("user_id"));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>
        const BottomNav()), (Route<dynamic> route)=> false);
  } else {
    print("incorrect password");
  }
  // print("DATA: ${jsonData[0]}");
  return null;

}
