// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/.env.dart';
import 'package:trakk/models/directions_model.dart';
import 'package:trakk/.env.dart';

class DirectionsService {
  static const String _baseUrl = 'https://maps.googleapis.com';


  // DirectionsRepository({});

  Future<Directions> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final queryParameters = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    };

    var url =  Uri.https(_baseUrl, '/maps/api/directions/json?', queryParameters);
    
    final response = await http.get(url);

    // Check if response is successful
    var decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Directions.fromMap(decoded);
    }
    return null!;
  }
}