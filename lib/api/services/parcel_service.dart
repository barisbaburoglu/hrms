import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parcel_model.dart';

class ParcelService {
  static const String _baseUrl =
      'https://cbsapi.tkgm.gov.tr/megsiswebapi.v3.1/api/';
  Future<Parcel?> fetchParcelInfo(double latitude, double longitude) async {
    final url = '$_baseUrl/parsel/$latitude/$longitude';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Parcel.fromJson(data);
    } else {
      throw Exception('Failed to load parcel data');
    }
  }
}
