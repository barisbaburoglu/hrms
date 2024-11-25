import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_provider.dart';
import '../api/models/role_action_model.dart';
import '../api/models/role_model.dart';
import '../constants/colors.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/edit_form_role.dart';
import 'employee_controller.dart';

class RoleController extends GetxController {
  final EmployeeController employeesController = Get.put(EmployeeController());
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();

  DateTime? employmentDate;

  Rxn<Role> selectedRole = Rxn<Role>();

  var roles = <Role>[].obs;

  var selectedRoles = <int>[].obs;

  var isAllRolesSelected = false.obs;

  var roleActions = <RoleActionModel>[].obs;

  var filteredRoleActions = <RoleActionModel>[].obs;

  var actionSearchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchRoles();
  }

  void fetchRoles() async {
    try {
      roles.clear();
      var roleModel = await ApiProvider().roleService.fetchRoles();
      roles.value = roleModel.roles ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteRole(Role role) async {
    try {
      await ApiProvider().roleService.deleteUserRole(role);

      fetchRoles();
      employeesController.fetchEmployees();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveRole({Role? role}) async {
    try {
      if (role == null) {
        await ApiProvider().roleService.createUserRole(Role(
              normalizedName: "",
              concurrencyStamp: "",
              name: nameController.text,
            ));
      }

      fetchRoles();

      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void toggleRoleSelection(int roleId) {
    if (selectedRoles.contains(roleId)) {
      selectedRoles.remove(roleId);
    } else {
      selectedRoles.add(roleId);
    }

    isAllRolesSelected.value = selectedRoles.length == roles.length;
    update();
  }

  void removeRoleFromSelectedRoles(int roleId) {
    employeesController.employees
        .firstWhere((e) => e.id == employeesController.selectedEmployees.first)
        .identityUserRoles
        ?.removeWhere((role) => role.roleId == roleId);
    selectedRoles.remove(roleId);

    isAllRolesSelected.value = selectedRoles.length == roles.length;
    update();
  }

  void selectAllRoles(bool selectAll) {
    if (selectAll) {
      selectedRoles.value = roles.map((e) => e.id!).toList();
    } else {
      selectedRoles.clear();
    }
    isAllRolesSelected.value = selectAll;
  }

  void updateRolesBasedOnSelectedEmployees() {
    if (employeesController.selectedEmployees.length == 1) {
      // Tek bir çalışan seçili
      int selectedEmployeeId = employeesController.selectedEmployees.first;
      var employee = employeesController.employees
          .firstWhere((e) => e.id == selectedEmployeeId);

      // Çalışana ait rollerin ID'lerini seçilen rollere ekle
      selectedRoles.value = employee.identityUserRoles!
          .map((role) => role.roleId!)
          .toSet()
          .toList();
    } else {
      // Birden fazla çalışan seçiliyse rolleri temizle
      selectedRoles.clear();
    }

    // Tüm rollerin seçili olup olmadığını kontrol et
    isAllRolesSelected.value = selectedRoles.length == roles.length;
  }

  void roleAssign(RxList<int> selectedEmployees) async {
    if (selectedEmployees.isNotEmpty && selectedRoles.isNotEmpty) {
      // Burada API'ye seçili çalışan ve rol id'leri gönderilebilir
      for (var employee in selectedEmployees) {
        await ApiProvider()
            .roleService
            .assignEmployeeRole(employee, selectedRoles);
      }
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Rol ataması başarılı.",
          duration: const Duration(seconds: 3),
          iconData: Icons.check,
          backgroundColor: AppColor.primaryGreen,
        ),
      );
      employeesController.fetchEmployees();
    } else {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Lütfen en az bir çalışan ve bir rol seçin.",
          duration: const Duration(seconds: 3),
          iconData: Icons.warning,
          backgroundColor: AppColor.primaryOrange,
        ),
      );
    }
  }

  void setRoleFields(Role role) {
    nameController.text = role.name ?? '';
  }

  void clearRoleFields() {
    nameController.clear();
  }

  void openEditPopup(String title, Role? role) {
    actionSearchQuery.value = "";
    if (role != null) {
      fetchRoleActions(role.id!);
    }
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormRole(
          title: title,
          role: role,
        ),
      ),
    );
  }

  void setRole(Role? role) {
    selectedRole.value = role!;
  }

  void fetchRoleActions(int roleId) async {
    roleActions.value = [];
    try {
      roleActions.value =
          await ApiProvider().roleService.fetchRoleActions(roleId);
      searchAction(actionSearchQuery.value);
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<RoleActionModel> saveRoleAction(RoleActionModel? roleAction) async {
    RoleActionModel action = RoleActionModel();
    try {
      action =
          await ApiProvider().roleService.addUserRoleAction(RoleActionModel(
                roleId: roleAction!.roleId,
                actionGroup: roleAction.actionGroup,
                actionName: roleAction.actionName,
              ));

      // Get.showSnackbar(
      //   CustomGetBar(
      //     textColor: AppColor.secondaryText,
      //     message: "${roleAction.actionName} Yetkisi Eklendi!",
      //     duration: const Duration(seconds: 3),
      //     iconData: Icons.check,
      //     backgroundColor: AppColor.primaryGreen,
      //   ),
      // );

      //fetchRoleActions(roleAction.roleId!);
    } catch (e) {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "${roleAction?.actionName} Yetkisi Eklenemedi!",
          duration: const Duration(seconds: 3),
          iconData: Icons.error,
          backgroundColor: AppColor.primaryRed,
        ),
      );
    }

    return action;
  }

  Future<int> deleteRoleAction(RoleActionModel? roleAction) async {
    int result = 0;
    try {
      result =
          await ApiProvider().roleService.deleteUserRoleAction(roleAction!);

      // Get.showSnackbar(
      //   CustomGetBar(
      //     textColor: AppColor.secondaryText,
      //     message: "${roleAction.actionName} Yetkisi Kaldırıldı!",
      //     duration: const Duration(seconds: 3),
      //     iconData: Icons.check,
      //     backgroundColor: AppColor.primaryGreen,
      //   ),
      // );

      // fetchRoleActions(roleAction.roleId!);
    } catch (e) {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "${roleAction?.actionName} Yetkisi Kaldırılamadı!",
          duration: const Duration(seconds: 3),
          iconData: Icons.error,
          backgroundColor: AppColor.primaryRed,
        ),
      );
    }

    return result;
  }

  void toggleAction(int index) async {
    if (roleActions[index].id == null) {
      roleActions[index] = RoleActionModel(
        id: 1,
        actionGroup: roleActions[index].actionGroup,
        actionName: roleActions[index].actionName,
      );
    } else {
      roleActions[index] = RoleActionModel(
        id: null,
        actionGroup: roleActions[index].actionGroup,
        actionName: roleActions[index].actionName,
      );
    }
  }

  void searchAction(String query) {
    actionSearchQuery.value = query;
    if (query.isEmpty) {
      filteredRoleActions.value = roleActions;
    } else {
      filteredRoleActions.value = roleActions
          .where((action) => '${action.actionName?.toLowerCase()}'
              .contains(query.toLowerCase()))
          .toList();
    }
  }
}
