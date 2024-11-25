import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/place_google.dart';
import '../models/user_role_actions_model.dart';

class ApiService {
  final String baseUrl;
  final String apiKey = "AIzaSyCjuykcjzh76LDRr4uj80215JsyayYyUxM";
  final box = GetStorage();

  ApiService(this.baseUrl);

  // 401 hatası
  void _handleUnauthorized() {
    box.erase(); // Oturum verilerini temizle
    Get.offAllNamed('/sign-in');
  }

  List<UserRoleActionsModel>? userRoleActions;

  List<UserRoleActionsModel> getUserRoleActionsFromStorage() {
    final box = GetStorage();
    List<dynamic>? jsonList = box.read('userRoleActions');
    if (jsonList != null) {
      return jsonList
          .map((item) => UserRoleActionsModel.fromJson(item))
          .toList();
    }
    return [];
  }

  bool _hasPermission(String grup, String action) {
    userRoleActions = getUserRoleActionsFromStorage();
    if (userRoleActions!.isEmpty) return false;

    final userGroup = userRoleActions!.firstWhere(
      (element) => element.grup == grup,
      orElse: () => UserRoleActionsModel(grup: null, actions: []),
    );
    return userGroup.actions?.contains(action) ?? false;
  }

  Future<http.Response> _performRequest(
      String method, String endpoint, String? grup, String? action,
      {Map<String, dynamic>? body}) async {
    if (grup != null && action != null) {
      if (!_hasPermission(grup, action)) {
        throw Exception('UAA:Unauthorized access to $grup $action');
      }
    }

    final url = Uri.parse('$baseUrl$endpoint');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.read('accessToken')}'
    };

    final response = await (method == 'GET'
        ? http.get(url, headers: headers)
        : method == 'POST'
            ? http.post(url, headers: headers, body: json.encode(body))
            : method == 'PUT'
                ? http.put(url, headers: headers, body: json.encode(body))
                : method == 'PATCH'
                    ? http.patch(url, headers: headers, body: json.encode(body))
                    : method == 'DELETE'
                        ? http.delete(url, headers: headers)
                        : throw Exception('Invalid HTTP method'));

    if (response.statusCode == 401) {
      _handleUnauthorized();
    } else if (response.statusCode >= 400) {
      throw Exception('Failed request: ${response.statusCode}');
    }

    return response;
  }

  Future<http.Response> getRequest(
      String? grup, String? action, String endpoint) {
    return _performRequest('GET', endpoint, grup, action);
  }

  Future<http.Response> postRequest(String? grup, String? action,
      String endpoint, Map<String, dynamic> body) {
    return _performRequest('POST', endpoint, grup, action, body: body);
  }

  Future<http.Response> putRequest(String? grup, String? action,
      String endpoint, Map<String, dynamic> body) {
    return _performRequest('PUT', endpoint, grup, action, body: body);
  }

  Future<http.Response> patchRequest(String? grup, String? action,
      String endpoint, Map<String, dynamic> body) {
    return _performRequest('PATCH', endpoint, grup, action, body: body);
  }

  Future<http.Response> deleteRequest(
      String? grup, String? action, String endpoint) {
    return _performRequest('DELETE', endpoint, grup, action);
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
