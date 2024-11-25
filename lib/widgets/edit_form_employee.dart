import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/models/employee_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/employee_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormEmployee extends StatelessWidget {
  final String title;
  final Employee? employee;
  final EmployeeController controller = Get.find<EmployeeController>();

  EditFormEmployee({
    super.key,
    required this.title,
    this.employee,
  });

  @override
  Widget build(BuildContext context) {
    double inputWidth = kIsWeb ? 310 : double.infinity;
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    if (employee != null) {
      controller.setEmployeeFields(employee!);
    } else {
      controller.clearEmployeeFields();
    }

    return SizedBox(
      width: kIsWeb ? 740 : double.infinity,
      height: screenHeight,
      child: Card(
        color: AppColor.cardBackgroundColor,
        shadowColor: AppColor.cardShadowColor,
        margin: const EdgeInsets.all(AppDimension.kSpacing),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.kSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimension.kSpacing),
                    child: Divider(
                      height: 1,
                      color: AppColor.primaryAppColor.withOpacity(0.25),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .6,
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: AppDimension.kSpacing,
                        runSpacing: AppDimension.kSpacing / 2,
                        children: [
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              controller: controller.nameController,
                              label: "Adı",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              controller: controller.surnameController,
                              label: "Soyadı",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              controller: controller.emailController,
                              label: "E-mail",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              controller: controller.phoneController,
                              label: "Telefon",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              controller: controller.employeeNumberController,
                              label: "Çalışan Numarası",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          Obx(() => SizedBox(
                              width: inputWidth,
                              height: 50,
                              child: _buildCompanyDropdown())),
                          Obx(() => SizedBox(
                              width: inputWidth,
                              height: 50,
                              child: _buildEmployeeTypeDropdown())),
                          Obx(() => SizedBox(
                              width: inputWidth,
                              height: 50,
                              child: _buildDepartmentDropdown())),
                          Obx(() => SizedBox(
                              width: inputWidth,
                              height: 50,
                              child: _buildShiftDropdown())),
                          SizedBox(
                              width: inputWidth,
                              height: 40,
                              child: _buildDatePicker()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: AppDimension.kSpacing,
                spacing: AppDimension.kSpacing,
                children: [
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    backgroundColor: AppColor.primaryRed,
                    label: "Vazgeç",
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.secondaryText,
                    ),
                  ),
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    label: "Kaydet",
                    onPressed: () {
                      controller.saveEmployee(employee: employee);
                    },
                    icon: const Icon(
                      Icons.save,
                      color: AppColor.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyDropdown() {
    // Sample data for companies; replace with actual data
    final companies = controller.companies;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Şirket",
        labelStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryAppColor,
          ),
        ),
      ),
      value: controller.companyId.value,
      items: companies.map((company) {
        return DropdownMenuItem<int>(
          value: company.id,
          child: Text(
            company.name ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.setCompanyId(value);
      },
    );
  }

  Widget _buildEmployeeTypeDropdown() {
    // Sample data for employee types; replace with actual data
    final employeeTypes = controller.employeeTypes;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Çalışan Tipi",
        labelStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryAppColor,
          ),
        ),
      ),
      value: controller.employeeTypeId.value,
      items: employeeTypes.map((type) {
        return DropdownMenuItem<int>(
          value: type.id,
          child: Text(
            type.name ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.setEmployeeTypeId(value);
      },
    );
  }

  Widget _buildDepartmentDropdown() {
    // Sample data for departments; replace with actual data
    final departments = controller.departments;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Bölüm",
        labelStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryAppColor,
          ),
        ),
      ),
      value: controller.departmentId.value,
      items: departments.map((department) {
        return DropdownMenuItem<int>(
          value: department.id,
          child: Text(
            department.name ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.setDepartmentId(value);
      },
    );
  }

  Widget _buildShiftDropdown() {
    final shifts = controller.shifts;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Çalışma Takvimi",
        labelStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryAppColor,
          ),
        ),
      ),
      value: controller.shiftId.value,
      items: shifts.isNotEmpty
          ? shifts.map((shift) {
              return DropdownMenuItem<int>(
                value: shift.id,
                child: Text(
                  shift.name ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.primaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            }).toList()
          : [],
      onChanged: (value) {
        controller.setShiftId(value);
      },
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: controller.employmentDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          controller.setEmploymentDate(pickedDate);
          // `TextEditingController`'ı güncellemiyoruz çünkü widget yeniden oluşturulduğunda tarih görünür olacak.
          controller.update(); // GetX'de durumu güncellemek için.
        }
      },
      child: AbsorbPointer(
        child: GetBuilder<EmployeeController>(
          builder: (_) {
            return BaseInput(
              label: "İşe Alım Tarihi",
              controller: TextEditingController(
                text: controller.employmentDate != null
                    ? DateFormat('dd/MM/yyyy')
                        .format(controller.employmentDate!)
                    : '',
              ),
              isLabel: true,
              errorRequired: false,
              margin: EdgeInsets.zero,
              textInputType: TextInputType.text,
              inputFormatters: const [],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller
                      .setEmploymentDate(DateFormat('dd/MM/yyyy').parse(value));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
