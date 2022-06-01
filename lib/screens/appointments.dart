import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/classes/api/api.dart';
import '../classes/api/functions_api.dart';
import '../models/appointment_model.dart';
import '../widgets/sidenav.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String url = Api().searchApi;

  List data = []; //edited line

  Future<String> getSWData() async {
    http.Response response = await http.post(Uri.parse(url));
    var resBody = json.decode(response.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
    return "Sucess";
  }


  var items = ['Apple','Banana','Orange'];
  String dropdownvalue = 'Apple';

  DateTime selectedDate = DateTime.now();
  final TextEditingController _speciality = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getSWData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
          onPressed: ()=> _scaffoldKey.currentState!.openDrawer(),
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.settings),
              color: Colors.black,
              ),
        ],
      ),
      key: _scaffoldKey,
      drawer: const SideNav(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildHeader(),
          _buildApppointment(),
          _buildSpeciality(),
          _buildSpecialistResult(),
        ],
      ),
    );
  }



  SliverToBoxAdapter _buildHeader() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Text(
          "Book an Appointment",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildApppointment() {
    return SliverToBoxAdapter(
        child: Column(
          children: [
            Form(
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: data.map((item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (dynamic newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: ()
                              {
                                Appoint(_speciality.text);
                              },
                              child: const Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  SliverToBoxAdapter _buildSpeciality() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "All Specialities",
                  style: TextStyle(
                    fontSize: 20.0,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  SliverToBoxAdapter _buildSpecialistResult() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FutureBuilder(
            future: fetchAppointment(),
            builder: (context,  AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  // itemCount: 4,
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Appointment appoint = snapshot.data![index];
                    return Card(
                      elevation: 8,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Image(
                                    image: AssetImage("assets/images/logo.png"),
                                    height: 50,),
                                  Text(
                                    appoint.doctorName,
                                    style: const TextStyle(fontSize: 15.0, height: 1),
                                  ),
                                  Text(
                                    appoint.specialist,
                                    style: const TextStyle(fontSize: 15.0, height: 1),
                                  ),
                                  InkWell(
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
