import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  var currentTime = ''.obs;
  var currentDate = ''.obs;

  final DateFormat timeFormat = DateFormat('hh:mm a', 'tr');
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'tr');

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    _updateDate();
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = timeFormat.format(now);
    currentTime.value = formattedTime;
  }

  void _updateDate() {
    final DateTime now = DateTime.now();
    final String formattedDate = dateFormat.format(now);
    currentDate.value = formattedDate;
  }
}
