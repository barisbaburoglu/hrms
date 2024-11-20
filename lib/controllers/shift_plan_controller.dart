import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/weekly_shift_grouped_model.dart';
import 'package:intl/intl.dart';

import '../api/api_provider.dart';
import '../api/models/employee_model.dart';
import '../api/models/shift_day_model.dart';
import '../api/models/shift_model.dart';
import '../api/models/shift_off_day_model.dart';
import '../api/models/week_model.dart';

class ShiftPlanController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();

  var isLoading = false.obs;

  Rxn<int> shiftId = Rxn<int>();

  Rxn<int> weekId = Rxn<int>();

  var employees = <Employee>[].obs;

  var offDays = <ShiftOffDay>[].obs;

  var shifts = <Shift>[].obs;

  var weeks = <WeekModel>[].obs;

  var hoveringCells = <int, bool>{}.obs;

  var weeklyShiftGroupedList = <WeeklyShiftGroupedModel>[].obs;

  var weekofDayGroupedList = <ShiftDay>[].obs;

  RxList<ShiftDay> shiftDays = RxList<ShiftDay>([]);

  var filteredWeeklyShift = <WeeklyShiftGroupedModel>[].obs;

  final Map<int, String> weekShortDays = {
    1: 'Pzt',
    2: 'Sal',
    3: 'Çar',
    4: 'Per',
    5: 'Cum',
    6: 'Cts',
    7: 'Paz',
  };

  final Map<int, String> weekLongDays = {
    1: 'Pazartesi',
    2: 'Salı',
    3: 'Çarşamba',
    4: 'Perşembe',
    5: 'Cuma',
    6: 'Cumartesi',
    7: 'Pazar',
  };

  @override
  void onInit() {
    super.onInit();

    fetchShifts();
    fetchWeeks();
  }

  void fetchShifts() async {
    try {
      var shiftModel = await ApiProvider().shiftService.fetchShifts();
      shifts.value = shiftModel.shifts ?? [];
    } catch (e) {
      print("Hata: $e");
    }
    update();
  }

  void fetchWeeks() async {
    isLoading.value = true;

    try {
      var weekModel = await ApiProvider().shiftService.fetchWeeks();
      weeks.value = weekModel;
    } catch (e) {
      print("Hata: $e");
    }

    isLoading.value = false;
    setCurrentWeek();
  }

  Future<void> fetchShiftsDaysByDayOfWeek(int? shiftId, int? dayOfWeek) async {
    try {
      var modelList = await ApiProvider()
          .shiftService
          .fetchShiftsDaysByDayOfWeek(shiftId ?? 0, dayOfWeek ?? 0);
      weekofDayGroupedList.value = modelList;
    } catch (e) {
      print("Hata: $e");
    }

    update();
  }

  void fetchWeeklyShiftGrouped() async {
    isLoading.value = true;
    filteredWeeklyShift.clear();
    try {
      var modelList = await ApiProvider()
          .shiftService
          .fetchWeeklyShiftGrouped(weekId.value ?? 0);
      weeklyShiftGroupedList.value = modelList;

      filteredWeeklyShift.value = modelList;
    } catch (e) {
      print("Hata: $e");
    }

    isLoading.value = false;
  }

  Future<void> patchWeeklyEmployeeShift(
      int weeklyEmployeeShiftId, var filter) async {
    try {
      bool result = await ApiProvider()
          .shiftService
          .patchWeeklyEmployeeShift(weeklyEmployeeShiftId, filter);

      if (result) {
        Get.back();
      } else {
        print("Patch Weekly Employee Shift Failed!");
      }
    } catch (e) {
      print("Hata: $e");
    }

    update();
    fetchWeeklyShiftGrouped();
  }

  void setHovering(int cellId, bool isHovering) {
    hoveringCells[cellId] = isHovering;
    update();
  }

  bool isHovering(int cellId) {
    return hoveringCells[cellId] ?? false;
  }

  void setWeekId(int? id) async {
    weekId.value = id!;
  }

  void createShiftPlan() {
    fetchWeeklyShiftGrouped();
  }

  String formatDateRange(String startDate, String endDate) {
    // Tarihleri DateTime olarak parse ediyoruz.
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);

    // Gerekli formatlar
    String dayFormat = DateFormat.d('tr').format(start); // Sadece günü alıyoruz
    String monthYearFormat =
        DateFormat("MMMM yyyy", 'tr').format(end); // Ay ve yılı alıyoruz

    return "$dayFormat - ${end.day} $monthYearFormat";
  }

  void setCurrentWeek() {
    // Bugünün tarihini al
    DateTime today = DateTime.now();

    // Haftalar listesini kontrol et
    for (var week in weeks) {
      DateTime startDate = DateTime.parse(week.startDate!);
      DateTime endDate = DateTime.parse(week.endDate!);

      // Bugün bu aralıkta mı?
      if (today.isAfter(startDate.subtract(const Duration(days: 1))) &&
          today.isBefore(endDate.add(const Duration(days: 1)))) {
        // Uygun hafta bulundu, weekId'yi set et
        setWeekId(week.weekId);

        createShiftPlan();
        break;
      }
    }
  }

  int getTotalDuration(List<Days>? days) {
    return days!
        .asMap()
        .entries
        .map((entry) => entry.value.shiftDuration)
        .fold(0, (previous, current) => previous + current!);
  }

  void searchWeeklyShift(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredWeeklyShift.value = weeklyShiftGroupedList;
    } else {
      filteredWeeklyShift.value = weeklyShiftGroupedList
          .where((action) =>
              '${action.employeeName?.toLowerCase()} ${action.employeeNumber?.toString().toLowerCase()}'
                  .contains(query.toLowerCase()))
          .toList();
    }
  }
}
