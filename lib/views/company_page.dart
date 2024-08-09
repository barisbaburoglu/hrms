import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/page_title.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/company_controller.dart';
import 'master_scaffold.dart';

class CompanyPage extends StatelessWidget {
  final CompanyController controller = Get.put(CompanyController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 8, extended: true);

  CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth < 1280 ? double.infinity : 1280;

          return Obx(
            () => SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width,
                      child: PageTitleWidget(
                        title: "Şirket Oluşturma",
                        rightWidgets: BaseButton(
                          label: "Yeni",
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.secondaryText,
                          ),
                          onPressed: () {
                            controller.openEditPopup(
                                "Yeni Şirket Oluşturma", null);
                          },
                        ),
                      )),
                  SizedBox(width: width, child: titleCardWidget()),
                  Expanded(
                    child: controller.companies.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(width: width, child: itemsCardWidget()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                "#",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 150,
              child: Text(
                "Şirket Adı",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 150,
                child: Text(
                  "Yönetici Adı",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 150,
                child: Text(
                  "Yönetici E-Mail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 150,
                child: Text(
                  "Yönetici Telefonu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              width: 75,
              child: Text(
                "Düzenle",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemsCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimension.kSpacing,
          vertical: AppDimension.kSpacing / 2),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.companies.length,
            itemBuilder: (context, index) {
              final company = controller.companies[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimension.kSpacing / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            "${index + 1}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            company.name ?? "",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Visibility(
                          visible:
                              MediaQuery.of(Get.context!).size.width > 1280,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              company.managerName ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              MediaQuery.of(Get.context!).size.width > 1280,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              company.managerEmail ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              MediaQuery.of(Get.context!).size.width > 1280,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              company.managerPhone ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.openEditPopup(
                                      "Şirket Düzenleme", company);
                                },
                                icon: const Icon(
                                  Icons.edit_square,
                                  color: AppColor.primaryOrange,
                                ),
                              ),
                              const SizedBox(
                                width: AppDimension.kSpacing,
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.deleteCompany(company);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColor.primaryRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: AppColor.primaryAppColor.withOpacity(0.25),
                  )
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
