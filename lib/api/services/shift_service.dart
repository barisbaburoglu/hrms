import 'dart:convert';

import 'package:hrms/api/models/week_model.dart';
import 'package:hrms/api/models/weekly_shift_grouped_model.dart';

import '../models/shift_day_model.dart';
import '../models/shift_model.dart';
import '../models/shift_off_day_model.dart';
import 'api_service.dart';

class ShiftService {
  final ApiService apiService;

  ShiftService(this.apiService);

  Future<ShiftModel> fetchShifts() async {
    final response = await apiService.postRequest('ShiftService',
        'PostAllShift', '/ShiftServices/All', {"orders": [], "filters": []});
    return ShiftModel.fromJson(json.decode(response.body));
  }

  Future<Shift> createShift(Shift shift) async {
    final response = await apiService.postRequest(
        'ShiftService', 'AddShift', '/ShiftServices', shift.toJson());
    return Shift.fromJson(json.decode(response.body));
  }

  Future<void> updateShift(Shift shift) async {
    await apiService.putRequest(
        'ShiftService', 'UpdateShift', '/ShiftServices', shift.toJson());
  }

  Future<void> deleteShift(int shiftId) async {
    await apiService.deleteRequest(
        'ShiftService', 'DeleteShift', '/ShiftServices?Id=$shiftId');
  }

  Future<ShiftDayModel> getShiftDaysByShiftId(int shiftId) async {
    final response = await apiService.postRequest(
        'ShiftDayService', 'PostAllShiftDay', '/ShiftDayServices/All', {
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

  Future<List<ShiftDay>> fetchShiftsDaysByDayOfWeek(int dayOfWeek) async {
    final response = await apiService.postRequest(
        'ShiftDayService', 'PostAllShiftDay', '/ShiftDayServices/All', {
      "orders": [],
      "filters": [
        {
          "fieldName": "DayOfWeek",
          "operator": "=",
          "fieldValue": dayOfWeek,
        }
      ]
    });

    List<dynamic> jsonListData = json.decode(response.body)["results"];

    return jsonListData.map((json) => ShiftDay.fromJson(json)).toList();
  }

  Future<void> createShiftDay(ShiftDay shiftDay) async {
    await apiService.postRequest('ShiftDayService', 'AddShiftDay',
        '/ShiftDayServices', shiftDay.toJson());
  }

  Future<void> updateShiftDay(ShiftDay shiftDay) async {
    await apiService.putRequest('ShiftDayService', 'UpdateShiftDay',
        '/ShiftDayServices', shiftDay.toJson());
  }

  //

  Future<ShiftOffDayModel> fetchOffDays(int employeeId) async {
    final response = await apiService.postRequest(
      'EmployeeShiftDayOffService',
      'PostAllEmployeeShiftDayOff',
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
      'EmployeeShiftDayOffService',
      'AddEmployeeShiftDayOff',
      '/EmployeeShiftDayOffServices',
      {
        "employeeId": employeeId,
        "dayOfWeek": dayOfweek,
      },
    );
    return ShiftOffDay.fromJson(json.decode(response.body));
  }

  Future<void> deleteOffDay(int offDayId) async {
    await apiService.deleteRequest(
        'EmployeeShiftDayOffService',
        'DeleteEmployeeShiftDayOff',
        '/EmployeeShiftDayOffServices?Id=$offDayId');
  }

  Future<List<WeekModel>> fetchWeeks() async {
    final response = await apiService.getRequest(
      'WeeklyEmployeeShiftService',
      'GetWeeks',
      '/WeeklyEmployeeShiftServices/Weeks',
    );

    List<dynamic> jsonListData = json.decode(response.body);

    return jsonListData.map((json) => WeekModel.fromJson(json)).toList();
  }

  Future<List<WeeklyShiftGroupedModel>> fetchWeeklyShiftGrouped(
      int weekId) async {
    final response = await apiService.postRequest(
      'WeeklyEmployeeShiftService',
      'PostGrouped',
      '/WeeklyEmployeeShiftServices/Grouped',
      {
        "weekId": weekId,
      },
    );

    List<dynamic> jsonListData = json.decode(response.body);

    return jsonListData
        .map((json) => WeeklyShiftGroupedModel.fromJson(json))
        .toList();
  }

  Future<bool> patchWeeklyEmployeeShift(
      int weeklyEmployeeShiftId, var filter) async {
    final response = await apiService.patchRequest(
      'WeeklyEmployeeShiftService',
      'PatchWeeklyEmployeeShift',
      '/WeeklyEmployeeShiftServices/$weeklyEmployeeShiftId',
      filter,
    );

    int data = json.decode(response.body);

    return data == 1;
  }
}
