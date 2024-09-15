import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/shift_day_model.dart';
import 'package:intl/intl.dart';
import '../api/api_provider.dart';
import '../api/models/shift_model.dart';
import '../widgets/edit_form_shift.dart';

class ShiftController extends GetxController {
  final ScrollController scrollController = ScrollController();

  String? startTime;

  var shiftCalendars = <Shift>[].obs;
  var isLoading = false.obs;

  // Form için TextEditingController
  TextEditingController nameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  var isOffDay = false.obs;

  final List<String> daysOfWeek = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];

  RxList<ShiftDay> shiftDays = RxList<ShiftDay>([]);

  void createDefaultShiftDays() {
    for (int i = 0; i < 7; i++) {
      shiftDays.add(
        ShiftDay(
          id: 0,
          companyId: 1,
          shiftId: 1,
          startTime: '08:00',
          endTime: '17:00',
          isOffDay: false,
          dayOfWeek: i + 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  String calculateDuration(String startTime, String endTime) {
    final format = DateFormat('HH:mm');
    final start = format.parse(startTime);
    final end = format.parse(endTime);
    final duration = end.difference(start);
    return duration.inHours.toString();
  }

  Future<TimeOfDay?> selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return picked;
  }

  @override
  void onInit() {
    super.onInit();
    fetchShiftCalendars();
  }

  void fetchShiftCalendars() async {
    isLoading.value = true;
    var shiftModel = await ApiProvider().shiftService.fetchShifts();
    shiftCalendars.value = shiftModel.shifts ?? [];
    isLoading.value = false;
  }

  void updateShiftTime(int index, String startTime, String endTime) {
    shiftDays[index] = shiftDays[index].copyWith(
      startTime: startTime,
      endTime: endTime,
    );
  }

  void deleteShiftCalendar(int id) async {
    isLoading.value = true;
    await ApiProvider().shiftService.deleteShift(id);
    fetchShiftCalendars();
  }

  void openEditPopup(String title, Shift? shift) async {
    await fetchShiftDays(shift?.id ?? 0);

    // Eğer shiftDays listesi boşsa varsayılan shiftDays'leri oluştur.
    if (shiftDays.isEmpty) {
      createDefaultShiftDays();
    }

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormShift(
          title: title,
          shift: shift,
        ),
      ),
    );
  }

  Future<void> saveShift({Shift? shift}) async {
    Get.back();
    isLoading.value = true;
    try {
      if (shift == null) {
        shift = await ApiProvider().shiftService.createShift(Shift(
              name: nameController.text,
              companyId: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ));
      } else {
        await ApiProvider().shiftService.updateShift(Shift(
              id: shift.id,
              companyId: shift.companyId,
              name: nameController.text,
              updatedAt: DateTime.now(),
            ));
      }
      for (var shiftDay in shiftDays) {
        await saveShiftDay(shiftDay: shiftDay, shiftId: shift.id!);
      }
      fetchShiftCalendars();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveShiftDay({ShiftDay? shiftDay, required int shiftId}) async {
    try {
      if (shiftDay != null && shiftDay.id != 0) {
        await ApiProvider().shiftService.updateShiftDay(ShiftDay(
              id: shiftDay.id,
              shiftId: shiftId,
              companyId: shiftDay.companyId,
              isOffDay: shiftDay.isOffDay,
              startTime: shiftDay.startTime,
              endTime: shiftDay.endTime,
              dayOfWeek: shiftDay.dayOfWeek,
              duration: shiftDay.duration,
              updatedAt: DateTime.now(),
            ));
      } else {
        await ApiProvider().shiftService.createShiftDay(ShiftDay(
              shiftId: shiftId,
              companyId: shiftDay!.companyId,
              isOffDay: shiftDay.isOffDay,
              startTime: shiftDay.startTime,
              endTime: shiftDay.endTime,
              dayOfWeek: shiftDay.dayOfWeek,
              duration: shiftDay.duration,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ));
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> fetchShiftDays(int shiftId) async {
    isLoading.value = true;
    var shiftDayModel =
        await ApiProvider().shiftService.getShiftDaysByShiftId(shiftId);
    shiftDays.value = shiftDayModel.shiftDays ?? [];
    isLoading.value = false;
  }
}
