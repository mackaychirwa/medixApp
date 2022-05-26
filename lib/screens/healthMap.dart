import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../bloc/appBloc.dart';
import '../models/placeLocation.dart';
import '../widgets/loading.dart';
import '../widgets/sidenav.dart';

class HealthMap extends StatefulWidget {
  const HealthMap({Key? key}) : super(key: key);

  @override
  State<HealthMap> createState() => _HealthMapState();
}

class _HealthMapState extends State<HealthMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}