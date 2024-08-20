import 'dart:convert';

import '../models/login_model.dart';
import '../models/login_response.model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<LoginResponseModel> login(LogInModel logInModel) async {
    final response = await apiService.postRequest(
        '/login?useCookies=false&useSessionCookies=false', logInModel.toJson());
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<LoginResponseModel> refreshToken(String refreshToken) async {
    final response = await apiService
        .postRequest('/refresh', {'refreshToken': refreshToken});
    return LoginResponseModel.fromJson(json.decode(response.body));
  }
}
