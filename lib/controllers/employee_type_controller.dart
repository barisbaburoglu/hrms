import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/employee_type_model.dart';
import 'package:hrms/widgets/edit_form_employee_type.dart';

import '../api/api_provider.dart';

class EmployeeTypeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var employeeTypes = <EmployeeType>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeTypes();
  }

  void fetchEmployeeTypes() async {
    try {
      var employeeTypeModel =
          await ApiProvider().employeeTypeService.fetchEmployeeTypes();
      employeeTypes.value = employeeTypeModel.employeeTypes ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteEmployeeType(EmployeeType employeType) async {
    try {
      await ApiProvider().employeeTypeService.deleteEmployeeType(employeType);

      fetchEmployeeTypes();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveEmployeeType({EmployeeType? employeType}) async {
    try {
      if (employeType == null) {
        await ApiProvider().employeeTypeService.createEmployeeType(EmployeeType(
              name: nameController.text,
              description: descriptionController.text,
            ));
      } else {
        await ApiProvider().employeeTypeService.updateEmployeeType(EmployeeType(
              id: employeType.id,
              name: nameController.text,
              description: descriptionController.text,
            ));
      }
      fetchEmployeeTypes();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setEmployeeTypeFields(EmployeeType employeType) {
    nameController.text = employeType.name ?? '';
    descriptionController.text = employeType.description ?? '';
  }

  void clearEmployeeTypeFields() {
    nameController.clear();
    descriptionController.clear();
  }

  void openEditPopup(String title, EmployeeType? employeType) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormEmployeeType(
          title: title,
          employeeType: employeType,
        ),
      ),
    );
  }
}
