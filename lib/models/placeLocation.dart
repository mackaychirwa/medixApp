class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Location(
        lat: parsedJson['lat'],
        lng: parsedJson['lng']);
  }
}

class Geometry {
  final Location location;

  Geometry({required this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Geometry(
        location: Location.fromJson(parsedJson['location'])
    );
  }
}

class Place {
  final Geometry geometry;
  final String name;
  // final String vicinity;

  Place({required this.geometry, required this.name});
  factory Place.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        // vicinity: parsedJson['vicinity']
    );
  }
}