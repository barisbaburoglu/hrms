import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrms/api/models/dash_record_model.dart';

import '../api/api_provider.dart';
import '../constants/colors.dart';
import '../widgets/edit_event_entry_exit.dart';

class DashboardController extends GetxController {
  GetStorage storageBox = GetStorage();
  Rx<int> touchedIndex = 0.obs;

  Rx<String> userNameSurname = "".obs;

  var dashRecords = Rxn<DashRecordModel>();

  @override
  void onInit() {
    super.onInit();
    dashRecords.value = DashRecordModel(
      absentEmployees: [],
      employeesOnLeave: [],
      lateEmployees: [],
      presentEmployees: [],
    );
    fetchDashRecords();
    // Gerekirse burada API'den veya herhangi bir kaynaktan verileri alabilirsiniz.
  }

  String getTitle(String category) {
    switch (category) {
      case 'present':
        return 'İşe Gelenler';
      case 'late':
        return 'Geç Gelenler';
      case 'absent':
        return 'İşe Gelmeyenler';
      case 'onLeave':
        return 'İzinli';
      case 'leftEarly':
        return 'Erken Çıkanlar';
      default:
        return '';
    }
  }

  void fetchDashRecords() async {
    String userName = storageBox.read('name') ?? "";
    String userSurName = storageBox.read('surname') ?? "";

    userNameSurname.value = "$userName $userSurName";
    try {
      dashRecords.value = await ApiProvider().dashService.fetchDashRecords();
      update();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void openEditEvent(String title) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditEventEntryExit(
          title: title,
        ),
      ),
    );
  }

  // List<PieChartSectionData> showingSections() {
  //   final totalEmployees = dashRecords.value?.totalEmployees;
  //   if (totalEmployees == null) {
  //     return [];
  //   }

  //   return List.generate(2, (i) {
  //     final isTouched = i == touchedIndex.value;
  //     final fontSize = isTouched ? 14.0 : 12.0;
  //     final radius = isTouched ? 70.0 : 65.0;
  //     final widgetSize = isTouched ? 55.0 : 40.0;
  //     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color: AppColor.primaryBlue,
  //           value: totalEmployees.totalMen.toDouble(),
  //           title: '${totalEmployees.totalMen}%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //             shadows: shadows,
  //           ),
  //           badgeWidget: _Badge(
  //             'male.png',
  //             size: widgetSize,
  //             borderColor: AppColor.primaryGreen,
  //           ),
  //           badgePositionPercentageOffset: 1.25,
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color: AppColor.primaryRed,
  //           value: totalEmployees.totalWomen.toDouble(),
  //           title: '${totalEmployees.totalWomen}%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //             shadows: shadows,
  //           ),
  //           badgeWidget: _Badge(
  //             'female.png',
  //             size: widgetSize,
  //             borderColor: AppColor.primaryGreen,
  //           ),
  //           badgePositionPercentageOffset: 1.25,
  //         );
  //       default:
  //         throw Exception('Oh no');
  //     }
  //   });
  // }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.assetName, {
    required this.size,
    required this.borderColor,
  });
  final String assetName;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/$assetName',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
