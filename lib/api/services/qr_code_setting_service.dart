import 'dart:convert';

import '../models/qr_code_setting_model.dart';
import 'api_service.dart';

class QRCodeSettingService {
  final ApiService apiService;

  QRCodeSettingService(this.apiService);

  Future<QRCodeSettingModel> fetchQRCodeSettings() async {
    final response = await apiService.postRequest(
        'QRCodeSettingService',
        'PostAllQRCodeSetting',
        '/QRCodeSettingServices/All',
        {"orders": [], "filters": []});
    return QRCodeSettingModel.fromJson(json.decode(response.body));
  }

  Future<QRCodeSettingModel> fetchQRCodeSettingById(int id) async {
    final response = await apiService.getRequest('QRCodeSettingService',
        'GetQRCodeSetting', '/QRCodeSettingServices/$id');
    return QRCodeSettingModel.fromJson(json.decode(response.body));
  }

  Future<void> createQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService.postRequest('QRCodeSettingService', 'AddQRCodeSetting',
        '/QRCodeSettingServices', qrCodeSetting.toJson());
  }

  Future<void> updateEmployeeType(QRCodeSetting qrCodeSetting) async {
    await apiService.putRequest('QRCodeSettingService', 'UpdateQRCodeSetting',
        '/QRCodeSettingServices', qrCodeSetting.toJson());
  }

  Future<void> deleteQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService.deleteRequest('QRCodeSettingService',
        'DeleteQRCodeSetting', '/QRCodeSettingServices?Id=${qrCodeSetting.id}');
  }
}
