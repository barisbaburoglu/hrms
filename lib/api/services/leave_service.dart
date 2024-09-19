import 'dart:convert';

import 'package:hrms/api/models/leave_model.dart';

import 'api_service.dart';

class LeaveService {
  final ApiService apiService;

  LeaveService(this.apiService);

  Future<LeaveModel> fetchLeaves(Map<String, dynamic>? filter) async {
    final response = await apiService.postRequest(
        '/LeaveRequestServices/All',
        filter ??
            {
              "orders": [
                {"fieldName": "EndDate", "direction": "desc"}
              ],
              "filters": []
            });
    return LeaveModel.fromJson(json.decode(response.body));
  }

  Future<Leave> fetchLeaveById(int id) async {
    final response = await apiService.getRequest('/LeaveRequestServices/$id');
    return Leave.fromJson(json.decode(response.body));
  }

  Future<void> createLeave(Leave leave) async {
    await apiService.postRequest('/LeaveRequestServices', leave.toJson());
  }

  Future<void> updateLeave(Leave leave) async {
    await apiService.putRequest('/LeaveRequestServices', leave.toJson());
  }

  Future<void> deleteLeave(int id) async {
    await apiService.deleteRequest('/LeaveRequestServices?Id=$id');
  }

  Future<void> patchLeave(int id, int status) async {
    await apiService
        .patchRequest('/LeaveRequestServices/$id', {"Status": status});
  }
}
