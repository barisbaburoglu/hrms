import 'dart:convert';

import '../models/company_model.dart';
import 'api_service.dart';

class CompanyService {
  final ApiService apiService;

  CompanyService(this.apiService);

  Future<CompanyModel> fetchCompanies() async {
    final response = await apiService
        .postRequest('/CompanyServices/All', {"orders": [], "filters": []});
    return CompanyModel.fromJson(json.decode(response.body));
  }

  Future<Company> fetchCompanyById(int id) async {
    final response = await apiService.getRequest('/CompanyServices/$id');
    return Company.fromJson(json.decode(response.body));
  }

  Future<void> createCompany(Company company) async {
    await apiService.postRequest('/CompanyServices', company.toJson());
  }

  Future<void> updateCompany(Company company) async {
    await apiService.putRequest('/CompanyServices', company.toJson());
  }

  Future<void> deleteCompany(Company company) async {
    await apiService.deleteRequest(
        '/CompanyServices?Id=${company.id}&Name=${company.name}&ManagerName=${company.managerName}&ManagerEmail=${company.managerEmail}&ManagerPhone=${company.managerPhone}');
  }
}
