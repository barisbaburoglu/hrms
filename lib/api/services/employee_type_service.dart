import 'dart:convert';

import '../models/employee_type_model.dart';
import 'api_service.dart';

class EmployeeTypeService {
  final ApiService apiService;

  EmployeeTypeService(this.apiService);

  Future<EmployeeTypeModel> fetchEmployeeTypes() async {
    final response = await apiService.postRequest(
        'EmployeeTypeService',
        'PostAllEmployeeType',
        '/EmployeeTypeServices/All',
        {"orders": [], "filters": []});
    return EmployeeTypeModel.fromJson(json.decode(response.body));
  }

  Future<EmployeeType> fetchEmployeeTypeById(int id) async {
    final response = await apiService.getRequest(
        'EmployeeTypeService', 'GetEmployeeType', '/EmployeeTypeServices/$id');
    return EmployeeType.fromJson(json.decode(response.body));
  }

  Future<void> createEmployeeType(EmployeeType employeeType) async {
    await apiService.postRequest('EmployeeTypeService', 'AddEmployeeType',
        '/EmployeeTypeServices', employeeType.toJson());
  }

  Future<void> updateEmployeeType(EmployeeType employeeType) async {
    await apiService.putRequest('EmployeeTypeService', 'UpdateEmployeeType',
        '/EmployeeTypeServices', employeeType.toJson());
  }

  Future<void> deleteEmployeeType(EmployeeType employeeType) async {
    await apiService.deleteRequest('EmployeeTypeService', 'FeleteEmployeeType',
        '/EmployeeTypeServices?Id=${employeeType.id}');
  }
}