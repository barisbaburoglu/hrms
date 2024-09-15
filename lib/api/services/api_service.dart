import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/place_google.dart';

class ApiService {
  final String baseUrl;
  final String apiKey = "AIzaSyCjuykcjzh76LDRr4uj80215JsyayYyUxM";
  final box = GetStorage();

  ApiService(this.baseUrl);

  // 401 hatası durumunda çalışacak fonksiyon
  void _handleUnauthorized() {
    box.erase(); // Oturum verilerini temizler
    Get.offAllNamed('/sign-in'); // Sign-in sayfasına yönlendirir
  }

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 401) {
      _handleUnauthorized();
    } else if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response;
  }

  Future<http.Response> postRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');

    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.read('accessToken')}'
      },
      body: body,
    );
    if (response.statusCode == 401) {
      _handleUnauthorized(); // 401 hatası için kontrol
    } else if (response.statusCode != 200) {
      throw Exception(response.statusCode);
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
    if (response.statusCode == 401) {
      _handleUnauthorized(); // 401 hatası için kontrol
    } else if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
    return response;
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url);
    if (response.statusCode == 401) {
      _handleUnauthorized(); // 401 hatası için kontrol
    } else if (response.statusCode != 200) {
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
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // 401 hatası için kontrol
      return [];
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
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // 401 hatası için kontrol
      return {};
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
