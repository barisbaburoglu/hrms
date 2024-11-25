import 'dart:convert';

import '../models/billing_information_model.dart';
import 'api_service.dart';

class BillingInformationService {
  final ApiService apiService;

  BillingInformationService(this.apiService);

  Future<BillingInformationModel> fetchBillingInformations() async {
    final response = await apiService.getRequest('BillingInformationService',
        'PostAllBillingInformation', '/BillingInformationServices/All');

    return BillingInformationModel.fromJson(json.decode(response.body));
  }

  Future<BillingInformation> fetchBillingInformationById(int id) async {
    final response = await apiService.getRequest('BillingInformationService',
        'GetBillingInformation', '/BillingInformationServices/$id');
    return BillingInformation.fromJson(json.decode(response.body));
  }

  Future<void> createBillingInformation(
      BillingInformation billingInformation) async {
    await apiService.postRequest(
        'BillingInformationService',
        'AddBillingInformation',
        '/BillingInformationServices',
        billingInformation.toJson());
  }

  Future<void> updateBillingInformation(
      BillingInformation billingInformation) async {
    await apiService.putRequest(
        'BillingInformationService',
        'UpdateBillingInformation',
        '/BillingInformationServices/${billingInformation.id}',
        billingInformation.toJson());
  }

  Future<void> deleteBillingInformation(int id) async {
    await apiService.deleteRequest('BillingInformationService',
        'DeleteBillingInformation', '/BillingInformationServices/$id');
  }
}
