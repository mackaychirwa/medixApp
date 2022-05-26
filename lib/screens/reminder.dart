import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/reminderdetail.dart';

import '../classes/api/api.dart';
import '../classes/api/functions_api.dart';
import '../models/prescription_model.dart';
import '../models/userdata.dart';
import '../widgets/sidenav.dart';
import 'package:http/http.dart' as http;

class PillReminder extends StatefulWidget {

  const PillReminder({Key? key}) : super(key: key);

  @override
  State<PillReminder> createState() => _PillReminderState();
}

class _PillReminderState extends State<PillReminder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _user_id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetchDosage();},
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      key: _scaffoldKey,
      drawer: const SideNav(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [_buildPill(), _buildText(), _buildCard()],
      ),
    );
  }

  SliverToBoxAdapter _buildPill() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 1.0, vertical: 40.0),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Center(
              child: Image(
                image: AssetImage("assets/images/capsule.png"),
                height: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildText() {
    return SliverToBoxAdapter(
      child: Container(
        height: 75,
        child: const Center(
          child: Text(
            "Today Pills",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCard() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchDosage(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot);
                    return ListView.builder(
                      // itemCount: 2,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Prescriptions dosage = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  ReminderDetail(dosage: snapshot.data[index],)));
                            },
                          child: Card(
                            elevation: 8,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    selectedColor: Colors.green,
                                    leading: const Icon(
                                      Icons.bloodtype_sharp,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    title: Text(dosage.prescriptionName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(dosage.prescriptionDetail),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: const Icon(Icons.healing, size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                      child: Text("No Prescriptions found for you today"),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
  Future remindUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user_id = (prefs.getString('user_id') ?? '');
    var api = Api().dosageApi;
    Map mapData = {
      'user_id': _user_id
    };
    http.Response response = await http.post(Uri.parse(api), body: mapData);
    var jsonData =  json.decode(response.body);

    if(jsonData != null) {
      print(jsonData['data']);
      return jsonData['data'];

    }
    return jsonData['data'];
  }
}
