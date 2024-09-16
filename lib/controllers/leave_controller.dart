import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';
import '../api/models/leave_model.dart';
import '../widgets/edit_form_leave.dart';

enum LeaveType {
  annual, // 0
  administrative, // 1
  health, // 2
  marriage, // 3
  paternity, // 4
  maternity, // 5
  breastfeeding, // 6
  caregiving, // 7
  travel, // 8
  radiation, // 9
  bereavement, // 10
  emergency, // 11
  unpaid, // 12
  other, // 13
}

class LeaveController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController leaveReasonController = TextEditingController();

  var leaves = <Leave>[].obs;

  DateTime? startDate;

  DateTime? endDate;

  var selectedLeaveType = LeaveType.annual.obs; // Default to annual leave

  // Map of LeaveType ids from JSON to enum
  Map<int, LeaveType> leaveTypeFromJson = {
    1: LeaveType.annual,
    2: LeaveType.administrative,
    3: LeaveType.health,
    4: LeaveType.marriage,
    5: LeaveType.paternity,
    6: LeaveType.maternity,
    7: LeaveType.breastfeeding,
    8: LeaveType.caregiving,
    9: LeaveType.travel,
    10: LeaveType.radiation,
    11: LeaveType.bereavement,
    12: LeaveType.emergency,
    13: LeaveType.unpaid,
    14: LeaveType.other,
  };

  Map<LeaveType, String> leaveTypeNames = {
    LeaveType.annual: "Yıllık İzin",
    LeaveType.administrative: "İdari İzin",
    LeaveType.health: "Sağlık İzni",
    LeaveType.marriage: "Evlilik İzni",
    LeaveType.paternity: "Babalık İzni",
    LeaveType.maternity: "Doğum İzni",
    LeaveType.breastfeeding: "Süt İzni",
    LeaveType.caregiving: "Refakat İzni",
    LeaveType.travel: "Yol İzni",
    LeaveType.radiation: "Şua İzni",
    LeaveType.bereavement: "Vefat İzni",
    LeaveType.emergency: "Mazeret İzni",
    LeaveType.unpaid: "Ücretsiz İzin",
    LeaveType.other: "Diğer",
  };

  Map<LeaveType, int> leaveTypeToId = {
    LeaveType.annual: 1,
    LeaveType.administrative: 2,
    LeaveType.health: 3,
    LeaveType.marriage: 4,
    LeaveType.paternity: 5,
    LeaveType.maternity: 6,
    LeaveType.breastfeeding: 7,
    LeaveType.caregiving: 8,
    LeaveType.travel: 9,
    LeaveType.radiation: 10,
    LeaveType.bereavement: 11,
    LeaveType.emergency: 12,
    LeaveType.unpaid: 13,
    LeaveType.other: 14,
  };

  @override
  void onInit() {
    super.onInit();
    fetchLeaves();
  }

  void fetchLeaves() async {
    try {
      var leaveModel = await ApiProvider().leaveService.fetchLeaves(null);
      leaves.value = leaveModel.leaves ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteLeave(int id) async {
    try {
      await ApiProvider().leaveService.deleteLeave(id);

      fetchLeaves();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveLeave({Leave? leave}) async {
    try {
      if (leave == null) {
        await ApiProvider().leaveService.createLeave(Leave(
              employeeId: 4,
              companyId: 1,
              leaveType: leaveTypeToId[selectedLeaveType.value],
              reason: leaveReasonController.text,
              startDate: DateFormat('yyyy-MM-dd').format(startDate!).toString(),
              endDate: DateFormat('yyyy-MM-dd').format(endDate!).toString(),
              status: 0,
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString(),
            ));
      } else {
        await ApiProvider().leaveService.updateLeave(Leave(
              id: leave.id,
              employeeId: 4,
              companyId: leave.companyId,
              leaveType: leaveTypeToId[selectedLeaveType.value],
              reason: leaveReasonController.text,
              startDate: DateFormat('yyyy-MM-dd').format(startDate!).toString(),
              endDate: DateFormat('yyyy-MM-dd').format(endDate!).toString(),
              status: leave.status,
              updatedAt: DateTime.now().toIso8601String(),
            ));
      }
      fetchLeaves();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setLeaveFields(Leave leave) {
    startDate = DateTime.parse(leave.startDate!);
    endDate = DateTime.parse(leave.endDate!);
    leaveReasonController.text = leave.reason ?? '';
    selectedLeaveType.value = leaveTypeFromJson[leave.leaveType]!;
  }

  void clearLeaveFields() {
    leaveReasonController.clear();
  }

  void openEditPopup(String title, Leave? leave) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormLeave(
          title: title,
          leave: leave,
        ),
      ),
    );
  }

  void setSelectedLeaveType(LeaveType leaveType) {
    selectedLeaveType.value = leaveType;
  }

  void setStartDate(DateTime date) {
    startDate = date;
    update();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    update();
  }
}
