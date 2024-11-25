import 'dart:convert';

import '../models/role_action_model.dart';
import '../models/role_model.dart';
import 'api_service.dart';

class RoleService {
  final ApiService apiService;

  RoleService(this.apiService);

  Future<RoleModel> fetchRoles() async {
    final response = await apiService.postRequest('UserRoleService', 'PostAll',
        '/UserRoleServices/All', {"orders": [], "filters": []});
    return RoleModel.fromJson(json.decode(response.body));
  }

  Future<RoleModel> fetchUserRoleById(int id) async {
    final response = await apiService.getRequest(
        'UserRoleService', 'Get', '/UserRoleServices/$id');
    return RoleModel.fromJson(json.decode(response.body));
  }

  Future<void> createUserRole(Role role) async {
    await apiService.postRequest(
        'UserRoleService', 'Add', '/UserRoleServices', role.toJson());
  }

  Future<void> deleteUserRole(Role role) async {
    await apiService.deleteRequest(
        'UserRoleService', 'Delete', '/UserRoleServices?Id=${role.id}');
  }

  Future<List<RoleActionModel>> fetchRoleActions(int roleId) async {
    final response = await apiService.getRequest(
        'UserRoleActionService',
        'GetUserRoleAction',
        '/UserRoleActionServices/RoleActions?roleId=$roleId');

    List<dynamic> data = json.decode(response.body);

    return data.map((json) => RoleActionModel.fromJson(json)).toList();
  }

  Future<RoleActionModel> addUserRoleAction(RoleActionModel roleAction) async {
    final response = await apiService.postRequest(
      'UserRoleActionService',
      'AddUserRoleAction',
      '/UserRoleActionServices',
      {
        "roleId": roleAction.roleId,
        "actionGroup": roleAction.actionGroup,
        "actionName": roleAction.actionName
      },
    );

    return RoleActionModel.fromJson(json.decode(response.body));
  }

  Future<int> deleteUserRoleAction(RoleActionModel roleAction) async {
    final response = await apiService.deleteRequest('UserRoleActionService',
        'DeleteUserRoleAction', '/UserRoleActionServices?Id=${roleAction.id}');

    return int.parse(response.body.toString());
  }

  Future<bool> assignEmployeeRole(int employeeId, List<int> roleList) async {
    final response = await apiService.putRequest(
      'UserService',
      'UpdateRolesOfEmployee',
      '/UserServices/RolesOfEmployee',
      {"roleIds": roleList, "employeeId": employeeId},
    );

    return bool.parse(response.body.toString());
  }
}
