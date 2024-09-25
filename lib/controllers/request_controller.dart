import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrms/widgets/edit_form_employee_request.dart';
import 'package:intl/intl.dart';

import '../api/api_provider.dart';
import '../api/models/employee_request_model.dart';
import '../api/models/leave_model.dart';
import '../api/models/qr_code_setting_model.dart';
import '../api/models/work_entry_exit_event_exception_model.dart';
import '../widgets/edit_form_event_request.dart';
import '../widgets/edit_form_request.dart';
import '../widgets/popup_employee_request_details.dart';
import '../widgets/popup_event_request_details.dart';
import '../widgets/popup_leave_request_details.dart';

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

class RequestController extends GetxController {
  GetStorage storageBox = GetStorage();

  final ScrollController scrollControllerEvent = ScrollController();
  final ScrollController scrollControllerLeave = ScrollController();
  final ScrollController scrollControllerEmployeeRequest = ScrollController();

  TextEditingController subjectController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController leaveReasonController = TextEditingController();

  var leaves = <Leave>[].obs;

  var eventExceptions = <WorkEntryExitEventException>[].obs;

  var employeeRequests = <EmployeeRequest>[].obs;

  DateTime? startDate;

  DateTime? endDate;

  var qrCodeSettings = <QRCodeSetting>[].obs;

  Rxn<QRCodeSetting> selectedLocation = Rxn<QRCodeSetting>();

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
    fetchEventExceptions();
    fetchQrCodeSettings();
    fetchLeaves();
    fetchEmployeeRequests();
  }

  void fetchQrCodeSettings() async {
    try {
      var qrCodeSettingModel =
          await ApiProvider().qrCodeSettingService.fetchQRCodeSettings();
      qrCodeSettings.value = qrCodeSettingModel.qrCodeSettings ?? [];
      update();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchLeaves() async {
    try {
      var leaveModel = await ApiProvider().leaveService.fetchLeaves(null);
      leaves.value = leaveModel.leaves ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchEventExceptions() async {
    try {
      var body = {
        "orders": [
          {"fieldName": "CreatedAt", "direction": "DESC"}
        ],
        "filters": []
      };
      var eventExceptionsModel = await ApiProvider()
          .usersEntryExitEventService
          .getWorkEntryExitEventExceptions(body);
      eventExceptions.value =
          eventExceptionsModel.workEntryExitEventExceptions ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchEmployeeRequests() async {
    try {
      var filter = {
        "orders": [
          {"fieldName": "createdAt", "direction": "DESC"}
        ],
        "filters": []
      };
      var employeeRequestModel =
          await ApiProvider().employeeService.fetchEmployeeRequests(filter);
      employeeRequests.value = employeeRequestModel.employeeRequests ?? [];
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

  void deleteEmployeeRequest(int id) async {
    try {
      await ApiProvider().employeeService.deleteEmployeeRequest(id);

      fetchLeaves();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveLeave({Leave? leave}) async {
    try {
      if (leave == null) {
        await ApiProvider().leaveService.createLeave(Leave(
              employeeId: storageBox.read("employeeId"),
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
              employeeId: storageBox.read("employeeId"),
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

  Future<void> saveEvent({WorkEntryExitEventException? eventException}) async {
    try {
      if (eventException == null) {
        await ApiProvider()
            .usersEntryExitEventService
            .createWorkEntryExitEventException(WorkEntryExitEventException(
              employeeId: storageBox.read("employeeId"),
              qrCodeSettingId: selectedLocation.value!.id,
              eventType: selectedLocation.value!.eventType,
              reason: leaveReasonController.text,
              eventTime: startDate!.toString(),
              status: 0,
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString(),
            ));
      } else {
        await ApiProvider()
            .usersEntryExitEventService
            .updateWorkEntryExitEventException(WorkEntryExitEventException(
              id: eventException.id,
              employeeId: storageBox.read("employeeId"),
              qrCodeSettingId: selectedLocation.value!.id,
              eventType: selectedLocation.value!.eventType,
              reason: leaveReasonController.text,
              eventTime: DateFormat('yyyy-MM-dd').format(startDate!).toString(),
              status: eventException.status,
              updatedAt: DateTime.now().toIso8601String(),
            ));
      }
      fetchEventExceptions();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveEmployeeRequest({EmployeeRequest? employeeRequest}) async {
    try {
      if (employeeRequest == null) {
        await ApiProvider()
            .employeeService
            .createEmployeeRequest(EmployeeRequest(
              employeeId: storageBox.read("employeeId"),
              subject: subjectController.text,
              detail: detailController.text,
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString(),
            ));
      } else {
        await ApiProvider()
            .employeeService
            .updateEmployeeRequest(EmployeeRequest(
              id: employeeRequest.id,
              employeeId: storageBox.read("employeeId"),
              subject: subjectController.text,
              detail: detailController.text,
              updatedAt: DateTime.now().toIso8601String(),
            ));
      }
      fetchEmployeeRequests();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> patchStatusLeave(int id, int status) async {
    try {
      Get.back();

      await ApiProvider().leaveService.patchLeave(id, status);

      fetchLeaves();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> patchStatusEvent(int id, int status) async {
    try {
      Get.back();

      await ApiProvider()
          .workEntryExitEventService
          .patchEventStatus(id, status);

      fetchEventExceptions();
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

  void setEventFields(WorkEntryExitEventException eventException) {
    startDate = DateTime.parse(eventException.eventTime!);
    leaveReasonController.text = eventException.reason ?? '';
    selectedLocation.value = qrCodeSettings
        .firstWhere((x) => x.id == eventException.qrCodeSettingId);
  }

  void setEmployeeRequestFields(EmployeeRequest employeeRequest) {
    subjectController.text = employeeRequest.subject!;
    detailController.text = employeeRequest.detail!;
  }

  void clearLeaveFields() {
    leaveReasonController.clear();
  }

  void clearEventFields() {
    selectedLocation.value = null;
  }

  void clearEmployeeRequestFields() {
    subjectController.text = "";
    detailController.text = "";
  }

  void openEditPopup(String title, Leave? leave) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormRequest(
          title: title,
          leave: leave,
        ),
      ),
    );
  }

  void openEventEditPopup(
      String title, WorkEntryExitEventException? workEntryExitEventException) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormEventRequest(
          title: title,
          workEntryExitEventException: workEntryExitEventException,
        ),
      ),
    );
  }

  void openEditEmployeeRequestPopup(
      String title, EmployeeRequest? employeeRequest) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormEmployeeRequest(
          title: title,
          employeeRequest: employeeRequest,
        ),
      ),
    );
  }

  void openLeaveRequestApprovalPopup(String title, Leave? leave) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: PopupLeaveRequestDetails(
          title: title,
          leave: leave,
        ),
      ),
    );
  }

  void openEventRequestApprovalPopup(
      String title, WorkEntryExitEventException? workEntryExitEventException) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: PopupEventRequestDetails(
          title: title,
          eventException: workEntryExitEventException,
        ),
      ),
    );
  }

  void openEmployeeRequestPopup(
      String title, EmployeeRequest? employeeRequest) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: PopupEmployeeRequestDetails(
          title: title,
          employeeRequest: employeeRequest,
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

  void setLocationId(QRCodeSetting? qrCodeSetting) {
    selectedLocation.value = qrCodeSetting!;
  }
}
