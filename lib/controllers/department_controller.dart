import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/department_model.dart';
import 'package:hrms/widgets/edit_form_department.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';

class DepartmentController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxInt? companyId = RxInt(1);

  var departments = <Department>[].obs;

  var companies = <Company>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchDepartments();

    fetchCompanies();
  }

  void fetchCompanies() async {
    try {
      var companyModel = await ApiProvider().companyService.fetchCompanies();

      companies.value = companyModel.companies ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchDepartments() async {
    try {
      var departmentModel =
          await ApiProvider().departmentService.fetchDepartments();
      departments.value = departmentModel.departments ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteDepartment(Department department) async {
    try {
      await ApiProvider().departmentService.deleteDepartment(department);

      fetchDepartments();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveDepartment({Department? department}) async {
    try {
      if (department == null) {
        await ApiProvider().departmentService.createDepartment(Department(
              companyId: companyId!.value,
              name: nameController.text,
              description: descriptionController.text,
            ));
      } else {
        await ApiProvider().departmentService.updateDepartment(Department(
              id: department.id,
              companyId: companyId!.value,
              name: nameController.text,
              description: descriptionController.text,
            ));
      }
      fetchDepartments();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setDepartmentFields(Department department) {
    companyId!.value = department.companyId ?? 1;
    nameController.text = department.name ?? '';
    descriptionController.text = department.description ?? '';
  }

  void clearDepartmentFields() {
    companyId!.value = 1;
    nameController.clear();
    descriptionController.clear();
  }

  void openEditPopup(String title, Department? department) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormDepartment(
          title: title,
          department: department,
        ),
      ),
    );
  }

  void setCompanyId(int? id) {
    companyId?.value = id!;
  }
}
