import 'package:trakk/utils/constant.dart';

class OnMoveResponse {
  OnMoveResponse({this.location, this.arrivalTimeInMin, this.distanceInKM});

  final OnMoveLocation? location;
  final int? arrivalTimeInMin;
  final String? distanceInKM;

  factory OnMoveResponse.fromJson(
      Map<String, dynamic> json, double lat, double long) {
    OnMoveLocation? _onMoveLocation = json["location"] == null
        ? null
        : OnMoveLocation.fromJson(json["location"]);
    int _arrivalTime = json["arrivalTime"] ?? 0;
    String _distanceInKm = '0.0';
    if (_onMoveLocation != null &&
        _onMoveLocation.coordinates != null &&
        _onMoveLocation.coordinates!.length > 1) {
      _distanceInKm =
          '${(Geolocator.distanceBetween(lat, long, _onMoveLocation.coordinates!.elementAt(1), _onMoveLocation.coordinates!.first).round() / 1000).toString()}';
      if (json["arrivalTime"] == null) {
        _arrivalTime =
            ((double.tryParse(_distanceInKm) / kSpeedInMinutes)).round();
      }
    }

    return OnMoveResponse(
        location: _onMoveLocation,
        arrivalTimeInMin: _arrivalTime,
        distanceInKM: _distanceInKm);
  }

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "arrivalTime": arrivalTimeInMin,
      };
}

class OnMoveLocation {
  OnMoveLocation({
    this.crs,
    this.type,
    this.coordinates,
  });

  final Crs? crs;
  final String? type;
  final List<double>? coordinates;

  factory OnMoveLocation.fromJson(Map<String, dynamic> json) {
    return OnMoveLocation(
      crs: json["crs"] == null ? null : Crs.fromJson(json["crs"]),
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? null
          : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
        "crs": crs == null ? null : crs!.toJson(),
        "type": type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Crs {
  Crs({
    this.type,
    this.properties,
  });

  final String? type;
  final Properties? properties;

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        type: json["type"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties == null ? null : properties!.toJson(),
      };
}

class Properties {
  Properties({
    this.name,
  });

  final String? name;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
