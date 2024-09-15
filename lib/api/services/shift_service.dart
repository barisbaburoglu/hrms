import 'dart:convert';

import '../models/shift_day_model.dart';
import '../models/shift_model.dart';
import '../models/shift_off_day_model.dart';
import 'api_service.dart';

class ShiftService {
  final ApiService apiService;

  ShiftService(this.apiService);

  Future<ShiftModel> fetchShifts() async {
    final response = await apiService
        .postRequest('/ShiftServices/All', {"orders": [], "filters": []});
    return ShiftModel.fromJson(json.decode(response.body));
  }

  Future<Shift> createShift(Shift shift) async {
    final response =
        await apiService.postRequest('/ShiftServices', shift.toJson());
    return Shift.fromJson(json.decode(response.body));
  }

  Future<void> updateShift(Shift shift) async {
    await apiService.putRequest('/ShiftServices', shift.toJson());
  }

  Future<void> deleteShift(int shiftId) async {
    await apiService.deleteRequest('/ShiftServices?Id=$shiftId');
  }

  Future<ShiftDayModel> getShiftDaysByShiftId(int shiftId) async {
    final response = await apiService.postRequest('/ShifDayServices/All', {
      "orders": [],
      "filters": [
        {
          "fieldName": "ShiftId",
          "operator": "=",
          "fieldValue": "$shiftId",
        }
      ]
    });
    return ShiftDayModel.fromJson(json.decode(response.body));
  }

  Future<void> createShiftDay(ShiftDay shiftDay) async {
    await apiService.postRequest('/ShifDayServices', shiftDay.toJson());
  }

  Future<void> updateShiftDay(ShiftDay shiftDay) async {
    await apiService.putRequest('/ShifDayServices', shiftDay.toJson());
  }

  //

  Future<ShiftOffDayModel> fetchOffDays(int employeeId) async {
    final response = await apiService.postRequest(
      '/EmployeeShiftDayOffServices/All',
      {
        "orders": [],
        "filters": [
          {
            "fieldName": "EmployeeId",
            "operator": "=",
            "fieldValue": "$employeeId",
          }
        ]
      },
    );
    return ShiftOffDayModel.fromJson(json.decode(response.body));
  }

  Future<ShiftOffDay> createOffDay(int employeeId, int dayOfweek) async {
    final response = await apiService.postRequest(
      '/EmployeeShiftDayOffServices',
      {
        "employeeId": employeeId,
        "dayOfWeek": dayOfweek,
      },
    );
    return ShiftOffDay.fromJson(json.decode(response.body));
  }

  Future<void> deleteOffDay(int offDayId) async {
    await apiService.deleteRequest('/EmployeeShiftDayOffServices?Id=$offDayId');
  }
}
