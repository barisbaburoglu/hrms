import 'dart:convert';

import '../models/employee_model.dart';
import '../models/employee_request_model.dart';
import 'api_service.dart';

class EmployeeService {
  final ApiService apiService;

  EmployeeService(this.apiService);

  Future<EmployeeModel> fetchEmployees(Map<String, dynamic>? filter) async {
    final response = await apiService.postRequest(
        '/EmployeeServices/All', filter ?? {"orders": [], "filters": []});
    return EmployeeModel.fromJson(json.decode(response.body));
  }

  Future<Employee> fetchEmployeeById(int id) async {
    final response = await apiService.getRequest('/EmployeeServices/$id');
    return Employee.fromJson(json.decode(response.body));
  }

  Future<void> createEmployee(Employee employee) async {
    await apiService.postRequest('/EmployeeServices', employee.toJson());
  }

  Future<void> updateEmployee(Employee employee) async {
    await apiService.putRequest('/EmployeeServices', employee.toJson());
  }

  Future<void> deleteEmployee(Employee employee) async {
    await apiService.deleteRequest(
        '/EmployeeServices?Id=${employee.id}&CompanyId=${employee.companyId}&EmployeeTypeId=${employee.employeeTypeId}&DepartmentId=${employee.departmentId}&EmployeeNumber=${employee.employeeNumber}&Name =${employee.name}&Surname=${employee.surname}&EmploymentDate=${employee.employmentDate}&Email=${employee.email}&Phone=${employee.phone}');
  }

  Future<EmployeeRequestModel> fetchEmployeeRequests(
      Map<String, dynamic>? filter) async {
    final response = await apiService.postRequest(
        '/EmployeeRequestServices/All',
        filter ?? {"orders": [], "filters": []});
    return EmployeeRequestModel.fromJson(json.decode(response.body));
  }

  Future<void> createEmployeeRequest(EmployeeRequest employeeRequest) async {
    await apiService.postRequest(
        '/EmployeeRequestServices', employeeRequest.toJson());
  }

  Future<void> updateEmployeeRequest(EmployeeRequest employeeRequest) async {
    await apiService.putRequest(
        '/EmployeeRequestServices', employeeRequest.toJson());
  }

  Future<void> deleteEmployeeRequest(int id) async {
    await apiService.deleteRequest('/EmployeeRequestServices?Id=$id');
  }
}
