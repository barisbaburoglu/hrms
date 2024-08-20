import 'dart:convert';

import '../models/department_model.dart';
import 'api_service.dart';

class DepartmentService {
  final ApiService apiService;

  DepartmentService(this.apiService);

  Future<DepartmentModel> fetchDepartments() async {
    final response = await apiService
        .postRequest('/DepartmentServices/All', {"orders": [], "filters": []});
    return DepartmentModel.fromJson(json.decode(response.body));
  }

  Future<Department> fetchDepartmentById(int id) async {
    final response = await apiService.getRequest('/DepartmentServices/$id');
    return Department.fromJson(json.decode(response.body));
  }

  Future<void> createDepartment(Department department) async {
    await apiService.postRequest('/DepartmentServices', department.toJson());
  }

  Future<void> updateDepartment(Department department) async {
    await apiService.putRequest('/DepartmentServices', department.toJson());
  }

  Future<void> deleteDepartment(Department department) async {
    await apiService.deleteRequest(
        '/DepartmentServices?Id=${department.id}&Name=${department.name}&Description=${department.description}');
  }
}
