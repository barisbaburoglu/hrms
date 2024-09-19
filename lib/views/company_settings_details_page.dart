import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/companies_settings_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class CompanySettingsDetailsPage extends StatelessWidget {
  final CompaniesSettingsController controller =
      Get.put(CompaniesSettingsController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 10, extended: true);

  CompanySettingsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double width = screenWidth < 1280 ? double.infinity : 1280;

          double inputWidth = screenWidth < 1280 ? double.infinity : 310;

          return Obx(
            () => SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width,
                      child: const PageTitleWidget(
                        title: "Şirket Ayarları",
                      )),
                  Expanded(
                    child: controller.companies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: width,
                            child: DefaultTabController(
                              length: 4,
                              child: tabDirection(
                                direction:
                                    screenWidth < 1280 ? "column" : "row",
                                children: [
                                  rotatedTabWidget(
                                      isMobile: screenWidth < 1280,
                                      tabs: const [
                                        Tab(text: 'Firma Bilgileri'),
                                        Tab(text: 'Fatura Bilgileri'),
                                        Tab(text: 'Bildirim Ayarları'),
                                        Tab(text: 'Genel Ayarlar'),
                                      ]),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        companyInformationTabBarView(
                                          inputWidth: inputWidth,
                                          screenHeight: screenHeight,
                                        ),
                                        billingInformationTabBarView(
                                          inputWidth: inputWidth,
                                        ),
                                        const Center(
                                            child: Text('Bildirim Ayarları')),
                                        const Center(
                                            child: Text('Genel Ayarlar')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget tabDirection(
      {required String direction, required List<Widget> children}) {
    return direction == "row"
        ? Row(
            children: children,
          )
        : Column(
            children: children,
          );
  }

  Widget tabWidget({required List<Widget> tabs}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimension.kSpacing),
      child: Card(
        child: TabBar(
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColor.primaryAppColor, width: 4),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(vertical: 5),
          tabs: tabs,
        ),
      ),
    );
  }

  Widget rotatedTabWidget(
      {required bool isMobile, required List<Widget> tabs}) {
    return isMobile
        ? tabWidget(
            tabs: tabs,
          )
        : RotatedBox(
            quarterTurns: -3,
            child: tabWidget(
              tabs: tabs.map((tab) {
                return RotatedBox(
                  quarterTurns: 3,
                  child: tab,
                );
              }).toList(),
            ),
          );
  }

  Widget companyInformationTabBarView(
      {required double inputWidth, required double screenHeight}) {
    return Center(
      child: SizedBox(
        height: double.infinity,
        child: Card(
          color: AppColor.cardBackgroundColor,
          shadowColor: AppColor.cardShadowColor,
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimension.kSpacing,
              vertical: AppDimension.kSpacing / 2),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.kSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.kSpacing),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Firma Bilgileri",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            BaseButton(
                              backgroundColor: AppColor.primaryOrange,
                              width: 150,
                              label: "Güncelle",
                              onPressed: () {
                                //controller.saveCompany(company: company);
                              },
                              icon: const Icon(
                                Icons.save,
                                color: AppColor.secondaryText,
                              ),
                            ),
                          ],
                        ),
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
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              isLabel: true,
                              errorRequired: false,
                              label: "Şirket Adı",
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
                              label: "Yönetici Adı",
                              controller: controller.managerNameController,
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
                              label: "Yönetici E-Mail",
                              controller: controller.managerEmailController,
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
                              label: "Yönetici Telefon Numarası",
                              controller: controller.managerPhoneController,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget billingInformationTabBarView({required double inputWidth}) {
    return Center(
      child: SizedBox(
        height: double.infinity,
        child: Card(
          color: AppColor.cardBackgroundColor,
          shadowColor: AppColor.cardShadowColor,
          margin: const EdgeInsets.all(AppDimension.kSpacing),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.kSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.kSpacing),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Fatura Bilgileri",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            BaseButton(
                              backgroundColor: AppColor.primaryOrange,
                              width: 150,
                              label: "Güncelle",
                              onPressed: () {
                                //controller.saveCompany(company: company);
                              },
                              icon: const Icon(
                                Icons.save,
                                color: AppColor.secondaryText,
                              ),
                            ),
                          ],
                        ),
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
                          SizedBox(
                            width: inputWidth,
                            height: 40,
                            child: BaseInput(
                              isLabel: true,
                              errorRequired: false,
                              label: "Firma Ünvanı",
                              controller: controller.businessNameController,
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
                              label: "Adres",
                              controller: controller.addressController,
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
                              label: "Semt",
                              controller: controller.districtController,
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
                              label: "İl",
                              controller: controller.cityController,
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
                              label: "Vergi No",
                              controller: controller.taxNumberController,
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
                              label: "Vergi Dairesi",
                              controller: controller.taxOfficeController,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
