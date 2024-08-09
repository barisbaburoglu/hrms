import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';
import '../api/models/department_model.dart';
import '../api/models/employee_model.dart';
import '../api/models/employee_type_model.dart';
import '../widgets/edit_form_employee.dart';

class EmployeeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();

  DateTime? employmentDate;
  RxInt? companyId = RxInt(1);
  RxInt? employeeTypeId = RxInt(1);
  RxInt? departmentId = RxInt(1);

  var employees = <Employee>[].obs;

  var companies = <Company>[].obs;

  var departments = <Department>[].obs;

  var employeeTypes = <EmployeeType>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
    fetchCompanies();
    fetchDepartments();
    fetchEmployeeTypes();
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

  void fetchEmployeeTypes() async {
    try {
      var employeeTypeModel =
          await ApiProvider().employeeTypeService.fetchEmployeeTypes();
      employeeTypes.value = employeeTypeModel.employeeTypes ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchEmployees() async {
    try {
      var employeeTypeModel =
          await ApiProvider().employeeService.fetchEmployees();
      employees.value = employeeTypeModel.employees ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteEmployee(Employee employe) async {
    try {
      await ApiProvider().employeeService.deleteEmployee(employe);

      fetchEmployees();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveEmployee({Employee? employee}) async {
    try {
      if (employee == null) {
        await ApiProvider().employeeService.createEmployee(Employee(
              companyId: companyId!.value,
              employeeTypeId: employeeTypeId!.value,
              departmentId: departmentId!.value,
              employeeNumber: int.parse(employeeNumberController.text),
              name: nameController.text,
              surname: surnameController.text,
              employmentDate: employmentDate.toString().substring(0, 10),
              email: emailController.text,
              phone: phoneController.text,
            ));
      } else {
        await ApiProvider().employeeService.updateEmployee(Employee(
              id: employee.id,
              companyId: companyId!.value,
              employeeTypeId: employeeTypeId!.value,
              departmentId: departmentId!.value,
              employeeNumber: int.parse(employeeNumberController.text),
              name: nameController.text,
              surname: surnameController.text,
              employmentDate: employmentDate.toString().substring(0, 10),
              email: emailController.text,
              phone: phoneController.text,
            ));
      }
      fetchEmployees();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setEmployeeFields(Employee employee) {
    nameController.text = employee.name ?? '';
    surnameController.text = employee.surname ?? '';
    emailController.text = employee.email ?? '';
    phoneController.text = employee.phone ?? '';
    employeeNumberController.text = employee.employeeNumber != null
        ? employee.employeeNumber.toString()
        : '0';

    employmentDate = DateTime.parse(employee.employmentDate!);
    companyId!.value = employee.companyId!;
    employeeTypeId!.value = employee.employeeTypeId!;
    departmentId!.value = employee.departmentId!;
  }

  void clearEmployeeFields() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    phoneController.clear();
    employeeNumberController.clear();
    employmentDate = null;
    companyId!.value = 1;
    employeeTypeId!.value = 1;
    departmentId!.value = 1;
  }

  void openEditPopup(String title, Employee? employee) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormEmployee(
          title: title,
          employee: employee,
        ),
      ),
    );
  }

  void setEmploymentDate(DateTime date) {
    employmentDate = date;
    update();
  }

  void setCompanyId(int? id) {
    companyId?.value = id!;
  }

  void setEmployeeTypeId(int? id) {
    employeeTypeId?.value = id!;
  }

  void setDepartmentId(int? id) {
    departmentId?.value = id!;
  }
}
