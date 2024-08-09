import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/department_controller.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/base_input.dart';
import '../api/models/company_model.dart';
import '../api/models/department_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class EditFormDepartment extends StatelessWidget {
  final String title;
  final Department? department;
  final DepartmentController controller = Get.put(DepartmentController());

  final RxInt selectedCompanyId = 1.obs;
  final List<Company> companyList = [
    Company(
        id: 1,
        name: "Şirket 1",
        managerName: "",
        managerEmail: "",
        managerPhone: ""),
    Company(
        id: 2,
        name: "Şirket 2",
        managerName: "",
        managerEmail: "",
        managerPhone: ""),
    Company(
        id: 3,
        name: "Şirket 3",
        managerName: "",
        managerEmail: "",
        managerPhone: ""),
  ];

  EditFormDepartment({
    super.key,
    required this.title,
    this.department,
  });

  @override
  Widget build(BuildContext context) {
    double inputWidth = kIsWeb ? 310 : double.infinity;
    double screenWidth = MediaQuery.of(Get.context!).size.width;

    if (department != null) {
      controller.setDepartmentFields(department!);
    } else {
      controller.clearDepartmentFields();
    }

    return SizedBox(
      width: kIsWeb ? 740 : double.infinity,
      height: 400,
      child: Card(
        color: AppColor.cardBackgroundColor,
        shadowColor: AppColor.cardShadowColor,
        margin: const EdgeInsets.all(AppDimension.kSpacing),
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
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: AppDimension.kSpacing,
                    runSpacing: AppDimension.kSpacing,
                    children: [
                      Obx(() => SizedBox(
                          width: inputWidth,
                          height: 60,
                          child: _buildCompanyDropdown())),
                      SizedBox(
                        width: inputWidth,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Departman Adı",
                          controller: controller.nameController,
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
                          isLabel: true,
                          errorRequired: false,
                          label: "Açıklama",
                          controller: controller.descriptionController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
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
                      controller.saveDepartment(department: department);
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
        labelText: 'Şirket',
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
      value: controller.companyId?.value,
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
}
