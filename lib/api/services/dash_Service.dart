// ignore: file_names
import 'dart:convert';

import '../models/dash_record_model.dart';
import 'api_service.dart';

class DashService {
  final ApiService apiService;

  DashService(this.apiService);

  Future<DashRecordModel> fetchDashRecords() async {
    final response = await apiService.getRequest(
      null,
      null,
      '/DashServices/DashRecord',
    );
    return DashRecordModel.fromJson(json.decode(response.body));
  }
}
