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
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');

    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer CfDJ8ClhByVBVwtLqPSz24y3ZXqRbMRYRoU0PKK0flGwk3nMl-gABLPJ9toJvGzHhSpxlytsrm50mD02tenRZ3Jp0wfzuNZJ7V8B8bYyg56pVlvmPHe-6qH2oIMwKfOf2dbZEUTIr9YstmryphbQD3wQUt_Ry9pq7l2FiIdDJu_BuSo5z7ujspLdMXSf_iyJfOYlDYYnlexpAq0i6Po07rl5K5bPKfPdI9bgR2U5GEsJoiDgbuQEvjY6kFDfALRBX25sI2jqX071ebq49WeKI5YUADB-wZcwxhsv3llz1DLHJRgeIK2B5UVWh82IraI1L4M-mJJfDirNsM8PPj2aGsiDML7OzF6Z4X2CPR8sl2SSPXWeUjvIGmKoT4V_O4aedEns309S_Dk1TF5Lwa5qqyUMSqD1onsk-ArRD20AbcSNYM73N-3383kjLs8VZPfonpez0HESanaWHqjEpaR18RtHJ1nma3C-m2o-l6XtuDBTUnZvxpyKnFyif_OwXZKsPWIQnymJdzz1Y4r_FDU5mXS9286F8UzG7ArpzmGGjvJ7a22cvR4dkcnkFpMAgPfvU0u91V2VzlLa3TSyzFy4eMjdyMb3ULYvdVSyjrNcsnlgcp1Uy78C8hCr9RyJl_ce2r4l1EGAE2tbqA8uhCb5-oIgKq_xm9khDY6KWPOCYmARt4unuNmCpbKXY7dYTaIka15DFbFPUbAZdlUfi86cgAJ8BVs'
      },
      body: body,
    );
    if (response.statusCode != 200) {
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
