import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/login_model.dart';
import '../models/login_response.model.dart';
import '../models/user_info_model.dart';
import '../models/user_role_actions_model.dart';
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

  Future<UserInfo> fetchUserInfo() async {
    final response = await apiService.getRequest('/api/USerServices/UserInfo');
    return UserInfo.fromJson(json.decode(response.body));
  }

  Future<List<UserRoleActionsModel>> fetchUserRoleActions() async {
    final response = await apiService
        .getRequest('/api/UserRoleActionServices/UserRoleActions');

    List<dynamic> data = json.decode(response.body);

    List<UserRoleActionsModel> actions =
        data.map((json) => UserRoleActionsModel.fromJson(json)).toList();

    saveUserRoleActionsToStorage(actions);

    return actions;
  }

  void saveUserRoleActionsToStorage(
      List<UserRoleActionsModel> userRoleActions) {
    final box = GetStorage();
    List<Map<String, dynamic>> jsonList =
        userRoleActions.map((item) => item.toJson()).toList();
    box.write('userRoleActions', jsonList); // JSON listesi olarak kaydet
  }
}
