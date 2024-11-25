import 'dart:convert';

import '../models/employee_model.dart';
import '../models/employee_request_model.dart';
import 'api_service.dart';

class EmployeeService {
  final ApiService apiService;

  EmployeeService(this.apiService);

  Future<EmployeeModel> fetchEmployees(Map<String, dynamic>? filter) async {
    final response = await apiService.postRequest(
        'EmployeeService',
        'PostAllEmployee',
        '/EmployeeServices/All',
        filter ?? {"orders": [], "filters": []});
    return EmployeeModel.fromJson(json.decode(response.body));
  }

  Future<Employee> fetchEmployeeById(int id) async {
    final response = await apiService.getRequest(
        'EmployeeService', 'GetEmployee', '/EmployeeServices/$id');
    return Employee.fromJson(json.decode(response.body));
  }

  Future<void> createEmployee(Employee employee) async {
    await apiService.postRequest('EmployeeService', 'AddEmployee',
        '/EmployeeServices', employee.toJson());
  }

  Future<void> updateEmployee(Employee employee) async {
    await apiService.putRequest('EmployeeService', 'UpdateEmployee',
        '/EmployeeServices', employee.toJson());
  }

  Future<void> deleteEmployee(Employee employee) async {
    await apiService.deleteRequest('EmployeeService', 'DeleteEmployee',
        '/EmployeeServices?Id=${employee.id}&CompanyId=${employee.companyId}&EmployeeTypeId=${employee.employeeTypeId}&DepartmentId=${employee.departmentId}&EmployeeNumber=${employee.employeeNumber}&Name =${employee.name}&Surname=${employee.surname}&EmploymentDate=${employee.employmentDate}&Email=${employee.email}&Phone=${employee.phone}');
  }

  Future<EmployeeRequestModel> fetchEmployeeRequests(
      Map<String, dynamic>? filter) async {
    final response = await apiService.postRequest(
        'EmployeeRequestService',
        'PostAllEmployeeRequest',
        '/EmployeeRequestServices/All',
        filter ?? {"orders": [], "filters": []});
    return EmployeeRequestModel.fromJson(json.decode(response.body));
  }

  Future<void> createEmployeeRequest(EmployeeRequest employeeRequest) async {
    await apiService.postRequest('EmployeeRequestService', 'AddEmployeeRequest',
        '/EmployeeRequestServices', employeeRequest.toJson());
  }

  Future<void> updateEmployeeRequest(EmployeeRequest employeeRequest) async {
    await apiService.putRequest(
        'EmployeeRequestService',
        'UpdateEmployeeRequest',
        '/EmployeeRequestServices',
        employeeRequest.toJson());
  }

  Future<void> deleteEmployeeRequest(int id) async {
    await apiService.deleteRequest('EmployeeRequestService',
        'DeleteEmployeeRequest', '/EmployeeRequestServices?Id=$id');
  }
}
