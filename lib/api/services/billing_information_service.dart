import 'dart:convert';

import '../models/billing_information_model.dart';
import 'api_service.dart';

class BillingInformationService {
  final ApiService apiService;

  BillingInformationService(this.apiService);

  Future<List<BillingInformation>> fetchBillingInformations() async {
    final response = await apiService.getRequest('/billing-informations');
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => BillingInformation.fromJson(json)).toList();
  }

  Future<BillingInformation> fetchBillingInformationById(int id) async {
    final response = await apiService.getRequest('/billing-informations/$id');
    return BillingInformation.fromJson(json.decode(response.body));
  }

  Future<void> createBillingInformation(
      BillingInformation billingInformation) async {
    await apiService.postRequest(
        '/billing-informations', billingInformation.toJson());
  }

  Future<void> updateBillingInformation(
      BillingInformation billingInformation) async {
    await apiService.putRequest(
        '/billing-informations/${billingInformation.id}',
        billingInformation.toJson());
  }

  Future<void> deleteBillingInformation(int id) async {
    await apiService.deleteRequest('/billing-informations/$id');
  }
}
