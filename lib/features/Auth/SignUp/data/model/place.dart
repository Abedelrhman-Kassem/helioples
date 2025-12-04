class Place {
  late Result result;

  Place.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = Result.fromJson(json['result']);
    } else {
      print("Received JSON: $json");
      throw Exception("Missing 'result' key in JSON.");
    }
  }
}

class Result {
  late Geometry geometry;

  Result.fromJson(dynamic json) {
    if (json['geometry'] != null) {
      geometry = Geometry.fromJson(json['geometry']);
    } else {
      throw Exception("Missing 'geometry' key in JSON.");
    }
  }
}

class Geometry {
  late Location location;

  Geometry.fromJson(dynamic json) {
    if (json['location'] != null) {
      location = Location.fromJson(json['location']);
    } else {
      throw Exception("Missing 'location' key in JSON.");
    }
  }
}

class Location {
  late double lat;
  late double lng;

  Location.fromJson(dynamic json) {
    lat = json['lat'] ?? (throw Exception("Missing 'lat' key in JSON."));
    lng = json['lng'] ?? (throw Exception("Missing 'lng' key in JSON."));
  }
}
