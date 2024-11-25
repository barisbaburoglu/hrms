import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_provider.dart';
import '../api/models/employee_model.dart';
import '../api/models/shift_day_model.dart';
import '../api/models/shift_model.dart';
import '../api/models/shift_off_day_model.dart';

class ShiftEmployeeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();

  var isLoading = false.obs;

  Rxn<int> shiftId = Rxn<int>();

  var employees = <Employee>[].obs;

  var offDays = <ShiftOffDay>[].obs;

  var shifts = <Shift>[].obs;

  RxList<ShiftDay> shiftDays = RxList<ShiftDay>([]);

  final Map<int, String> weekDays = {
    1: 'Pzt',
    2: 'Sal',
    3: 'Çar',
    4: 'Per',
    5: 'Cum',
    6: 'Cts',
    7: 'Paz',
  };

  @override
  void onInit() {
    super.onInit();

    fetchShifts();
  }

  void fetchShifts() async {
    isLoading.value = true;
    try {
      var shiftModel = await ApiProvider().shiftService.fetchShifts();
      shifts.value = shiftModel.shifts ?? [];
    } catch (e) {
      print("Hata: $e");
    }
    isLoading.value = false;
  }

  void fetchEmployees(int shiftId) async {
    isLoading.value = true;
    try {
      var employeeTypeModel =
          await ApiProvider().employeeService.fetchEmployees({
        "orders": [],
        "filters": [
          {"fieldName": "ShiftId", "operator": "=", "fieldValue": "$shiftId"}
        ]
      });
      employees.value = employeeTypeModel.employees ?? [];
    } catch (e) {
      print("Hata: $e");
    }
    isLoading.value = false;
  }

  void createOffDay(int employeeId, int dayOffWeek) async {
    isLoading.value = true;
    try {
      await ApiProvider().shiftService.createOffDay(employeeId, dayOffWeek);
      fetchEmployees(shiftId.value!);
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteOffDay(int offDayId) async {
    isLoading.value = true;
    try {
      await ApiProvider().shiftService.deleteOffDay(offDayId);
      fetchEmployees(shiftId.value!);
    } catch (e) {
      print("Hata: $e");
    }
    isLoading.value = false;
  }

  void fetchShiftDays(int shiftId) async {
    isLoading.value = true;
    try {
      var shiftDayModel =
          await ApiProvider().shiftService.getShiftDaysByShiftId(shiftId);
      shiftDays.value = shiftDayModel.shiftDays ?? [];
    } catch (e) {
      print("Hata: $e");
    }
    isLoading.value = false;
  }

  void setShiftId(int? id) async {
    shiftId.value = id!;
    fetchShiftDays(id);
    fetchEmployees(id);
  }
}
