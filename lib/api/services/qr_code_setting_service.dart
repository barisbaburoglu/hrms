import 'dart:convert';

import '../models/qr_code_setting_model.dart';
import 'api_service.dart';

class QRCodeSettingService {
  final ApiService apiService;

  QRCodeSettingService(this.apiService);

  Future<List<QRCodeSetting>> fetchQRCodeSettings() async {
    final response = await apiService.getRequest('/qr-code-settings');
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => QRCodeSetting.fromJson(json)).toList();
  }

  Future<QRCodeSetting> fetchQRCodeSettingById(int id) async {
    final response = await apiService.getRequest('/qr-code-settings/$id');
    return QRCodeSetting.fromJson(json.decode(response.body));
  }

  Future<void> createQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService.postRequest('/qr-code-settings', qrCodeSetting.toJson());
  }

  Future<void> updateQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    await apiService.putRequest(
        '/qr-code-settings/${qrCodeSetting.id}', qrCodeSetting.toJson());
  }

  Future<void> deleteQRCodeSetting(int id) async {
    await apiService.deleteRequest('/qr-code-settings/$id');
  }
}
