import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/shift_model.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';
import '../api/models/department_model.dart';
import '../api/models/employee_model.dart';
import '../api/models/employee_type_model.dart';
import '../widgets/edit_form_employee.dart';

class EmployeeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();

  DateTime? employmentDate;
  Rxn<int> companyId = Rxn<int>();
  Rxn<int> employeeTypeId = Rxn<int>();
  Rxn<int> departmentId = Rxn<int>();
  Rxn<int> shiftId = Rxn<int>();

  Rxn<Employee> selectedEmployee = Rxn<Employee>();

  var employees = <Employee>[].obs;

  var companies = <Company>[].obs;

  var departments = <Department>[].obs;

  var employeeTypes = <EmployeeType>[].obs;

  var shifts = <Shift>[].obs;

  var selectedEmployees = <int>[].obs;

  var isAllEmployeesSelected = false.obs;

  var filteredEmployees = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
    fetchCompanies();
    fetchDepartments();
    fetchEmployeeTypes();
    fetchShifts();
  }

  void fetchShifts() async {
    try {
      var shiftModel = await ApiProvider().shiftService.fetchShifts();
      shifts.value = shiftModel.shifts ?? [];
    } catch (e) {
      print("Hata: $e");
    }
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
      filteredEmployees.clear();
      var employeeTypeModel =
          await ApiProvider().employeeService.fetchEmployees(null);
      employees.value = employeeTypeModel.employees ?? [];
      filteredEmployees.value = employees;
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

  void toggleEmployeeSelection(int employeeId) {
    if (selectedEmployees.contains(employeeId)) {
      selectedEmployees.remove(employeeId);
    } else {
      selectedEmployees.add(employeeId);
    }
    isAllEmployeesSelected.value =
        selectedEmployees.length == filteredEmployees.length;
    update();
  }

  void selectAllEmployees(bool selectAll) {
    if (selectAll) {
      selectedEmployees.value = filteredEmployees.map((e) => e.id!).toList();
    } else {
      selectedEmployees.clear();
    }
    isAllEmployeesSelected.value = selectAll;
  }

  void searchEmployees(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredEmployees.value = employees;
    } else {
      filteredEmployees.value = employees
          .where((employee) =>
              '${employee.name?.toLowerCase()} ${employee.surname?.toLowerCase()} ${employee.employeeNumber}'
                  .contains(query.toLowerCase()))
          .toList();
    }

    isAllEmployeesSelected.value =
        selectedEmployees.length == filteredEmployees.length;
  }

  Future<void> saveEmployee({Employee? employee}) async {
    try {
      if (employee == null) {
        await ApiProvider().employeeService.createEmployee(Employee(
              companyId: companyId.value,
              employeeTypeId: employeeTypeId.value,
              departmentId: departmentId.value,
              shiftId: shiftId.value,
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
              companyId: companyId.value,
              employeeTypeId: employeeTypeId.value,
              departmentId: departmentId.value,
              shiftId: shiftId.value,
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
    companyId.value = employee.companyId!;
    employeeTypeId.value = employee.employeeTypeId!;
    departmentId.value = employee.departmentId!;
    shiftId.value = employee.shiftId!;
  }

  void clearEmployeeFields() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    phoneController.clear();
    employeeNumberController.clear();
    employmentDate = null;
    companyId.value = null;
    employeeTypeId.value = null;
    departmentId.value = null;
    shiftId.value = null;
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
    companyId.value = id!;
  }

  void setEmployee(Employee? employee) {
    selectedEmployee.value = employee!;
  }

  void setEmployeeTypeId(int? id) {
    employeeTypeId.value = id!;
  }

  void setDepartmentId(int? id) {
    departmentId.value = id!;
  }

  void setShiftId(int? id) {
    shiftId.value = id!;
  }

  // Çalışanın seçili olup olmadığını kontrol eder
  bool isEmployeeSelected(int employeeId) {
    return selectedEmployees.contains(employeeId);
  }

  // Tüm seçimleri temizler
  void clearSelections() {
    selectedEmployees.clear();
  }
}
