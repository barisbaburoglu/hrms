import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/place_google.dart';

class ApiService {
  final String baseUrl;
  final String apiKey = "AIzaSyCjuykcjzh76LDRr4uj80215JsyayYyUxM";

  ApiService(this.baseUrl);

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response;
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create data');
    }
    return response;
  }

  Future<http.Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    var body = json.encode(data);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
    return response;
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
    return response;
  }

  Future<List<Place>> fetchPlaces(String input) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:tr',
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final places = json['predictions'] as List;
      return places.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<Map<String, double>> fetchPlaceDetails(String placeId) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final location = json['result']['geometry']['location'];
      return {'lat': location['lat'], 'lng': location['lng']};
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
