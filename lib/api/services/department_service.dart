import 'dart:convert';

import '../models/department_model.dart';
import 'api_service.dart';

class DepartmentService {
  final ApiService apiService;

  DepartmentService(this.apiService);

  Future<DepartmentModel> fetchDepartments() async {
    final response = await apiService.postRequest(
        'DepartmentService',
        'PostAllDepartment',
        '/DepartmentServices/All',
        {"orders": [], "filters": []});
    return DepartmentModel.fromJson(json.decode(response.body));
  }

  Future<Department> fetchDepartmentById(int id) async {
    final response = await apiService.getRequest(
        'DepartmentService', 'GetDepartment', '/DepartmentServices/$id');
    return Department.fromJson(json.decode(response.body));
  }

  Future<void> createDepartment(Department department) async {
    await apiService.postRequest('DepartmentService', 'AddDepartment',
        '/DepartmentServices', department.toJson());
  }

  Future<void> updateDepartment(Department department) async {
    await apiService.putRequest('DepartmentService', 'UpdateDepartment',
        '/DepartmentServices', department.toJson());
  }

  Future<void> deleteDepartment(Department department) async {
    await apiService.deleteRequest('DepartmentService', 'DeleteDepartment',
        '/DepartmentServices?Id=${department.id}');
  }
}
