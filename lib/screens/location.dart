import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../bloc/appBloc.dart';
import '../models/placeLocation.dart';
import '../widgets/loading.dart';
import '../widgets/sidenav.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else {
        _locationController.text = "";
      }
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc?>(context, listen: false);
    applicationBloc!.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationbloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          color: Colors.black,
        ),
        title: const Text(
          'Location',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      key: _scaffoldKey,
      drawer: const SideNav(),
      body: (applicationbloc.currentLocation == null)
          ? const Center(
              child: Loading(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _locationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                        hintText: "Search location",
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (value) => applicationbloc.searchPlaces(value),
                    onTap: () => applicationbloc.clearSelectedLocation(),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 600,
                      child: GoogleMap(
                        mapType: MapType.satellite,
                        markers: Set<Marker>.of(applicationbloc.markers),
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            applicationbloc.currentLocation!.latitude,
                            applicationbloc.currentLocation!.longitude,
                          ),
                          zoom: 14,
                        ),
                      ),
                    ),
                    if (applicationbloc.searchResults != null &&
                        applicationbloc.searchResults!.length != 0)
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (applicationbloc.searchResults != null)
                      Container(
                        height: 300,
                        child: ListView.builder(
                            itemCount: applicationbloc.searchResults!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  applicationbloc
                                      .searchResults![index].description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    applicationbloc.setSelectedLocation(
                                      applicationbloc
                                          .searchResults![index].placeId,
                                    );
                                  });
                                },
                              );
                            }),
                      )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Find Nearest Place'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: const Text('ATM'),
                        onSelected: (val) =>
                            applicationbloc.togglePlaceType('atm', val),
                        selected: applicationbloc.placeType == 'atm',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: const Text('Filling Station'),
                        onSelected: (val) =>
                            applicationbloc.togglePlaceType('gas_station', val),
                        selected: applicationbloc.placeType == 'gas_station',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: const Text('Hospital'),
                        onSelected: (val) =>
                            applicationbloc.togglePlaceType('hospital', val),
                        selected: applicationbloc.placeType == 'hospital',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                          label: const Text('Pharmacy'),
                          onSelected: (val) =>
                              applicationbloc.togglePlaceType('pharmacy', val),
                          selected: applicationbloc.placeType == 'pharmacy',
                          selectedColor: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
