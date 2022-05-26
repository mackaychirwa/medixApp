import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/dummy/fake.dart';
import 'package:untitled/models/patients.dart';
import 'package:untitled/models/userdata.dart';
import 'package:untitled/widgets/category_card.dart';
import 'package:untitled/widgets/section.dart';
import 'package:http/http.dart' as http;
import '../classes/api/api.dart';
import '../classes/api/functions_api.dart';
import '../widgets/sidenav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _user_id = '';
  String? _role = '';
  final TextEditingController _searchResultController = TextEditingController();

  @override
  void initState() {
    _loadCounter();
    _loadCounters();

    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user_id = (prefs.getString('user_id') ?? '');
      _role = (prefs.getString('role') ?? '');
    });
  }
  _loadCounters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _email = (prefs.getString('email') ?? '');
      _role = (prefs.getString('role') ?? '');
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        title: const Text(
          'HomePage',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
          },
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
          _buildSearch(),
          _buildName(),
          _buildData(),
          _buildTestResults(),
          _buildRecentTest(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
        child: FutureBuilder(
          future: fetchUserData(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    UserData user = snapshot.data![index];
                    return Text(
                      "Good Morning ${user.email}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
              );
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }


  SliverToBoxAdapter _buildSearch() {
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
                  child: TextField(
                    controller: _searchResultController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                      labelText: "Search Result",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _searchResultController.text = (value),
                    onTap: () => _searchResultController.clear(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  SliverToBoxAdapter _buildName() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 20.0,
                    height: 1,
                  ),
                ),
                InkWell(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 18.0,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ),
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
    );
  }

  SliverToBoxAdapter _buildData() {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Column(
          children: [
            Section(
              "Category",
              Fake.category.map(
                (c) {
                  return CategoryCard(
                    title: c.title,
                    iconPath: c.iconPath,
                    onTap: () {

                    },
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTestResults() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Test Results",
                  style: TextStyle(fontSize: 20.0, height: 1),
                ),
                InkWell(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Text(
                        "View all",
                        style: TextStyle(
                            fontSize: 18.0, height: 1, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildRecentTest() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FutureBuilder(
            future: fetchPatients(),
            builder: (context,  AsyncSnapshot snapshot){
              if(snapshot.hasData){
               return ListView.builder(
                 itemCount: 3,
                 //  itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Patients patient = snapshot.data![index];
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
                                        const Icon(Icons.bloodtype_sharp, color: Colors.red),
                                         Text(
                                         patient.email,
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
  // Future fetchUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _user_id = (prefs.getString('user_id') ?? '');
  //   var api = Api().userdataApi;
  //   Map mapData = {
  //     'user_id': _user_id
  //   };
  //   http.Response response = await http.post(Uri.parse(api), body: mapData);
  //   var jsonData =  json.decode(response.body);
  //
  //   if(jsonData != null) {
  //     print(jsonData['data']['email']);
  //     return jsonData['data'];
  //
  //   }
  //   return jsonData['data'];
  // }

}
