import 'dart:convert';

import '../models/qr_code_setting_model.dart';
import 'api_service.dart';

class QRCodeSettingService {
  final ApiService apiService;

  QRCodeSettingService(this.apiService);

  Future<QRCodeSettingModel> fetchQRCodeSettings() async {
    final response = await apiService.postRequest(
        '/QRCodeSettingServices/All', {"orders": [], "filters": []});
    return QRCodeSettingModel.fromJson(json.decode(response.body));
  }

  Future<QRCodeSettingModel> fetchQRCodeSettingById(int id) async {
    final response = await apiService.getRequest('/QRCodeSettingServices/$id');
    return QRCodeSettingModel.fromJson(json.decode(response.body));
  }

  Future<void> createQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService.postRequest(
        '/QRCodeSettingServices', qrCodeSetting.toJson());
  }

  Future<void> updateEmployeeType(QRCodeSetting qrCodeSetting) async {
    await apiService.putRequest(
        '/QRCodeSettingServices', qrCodeSetting.toJson());
  }

  Future<void> deleteQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService
        .deleteRequest('/QRCodeSettingServices?Id=${qrCodeSetting.id}');
  }
}
