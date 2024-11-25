import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/edit_form_company.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';

class CompanyController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController managerPhoneController = TextEditingController();

  var companies = <Company>[].obs;
  var filteredCompanies = <Company>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  void fetchCompanies() async {
    try {
      var companyModel = await ApiProvider().companyService.fetchCompanies();
      companies.value = companyModel.companies ?? [];
      filteredCompanies.value = companyModel.companies ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteCompany(Company company) async {
    try {
      await ApiProvider().companyService.deleteCompany(company);

      fetchCompanies();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveCompany({Company? company}) async {
    try {
      if (company == null) {
        await ApiProvider().companyService.createCompany(Company(
              name: nameController.text,
              managerName: managerNameController.text,
              managerEmail: managerEmailController.text,
              managerPhone: managerPhoneController.text,
            ));
      } else {
        await ApiProvider().companyService.updateCompany(Company(
              id: company.id,
              name: nameController.text,
              managerName: managerNameController.text,
              managerEmail: managerEmailController.text,
              managerPhone: managerPhoneController.text,
            ));
      }
      fetchCompanies();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setCompanyFields(Company company) {
    nameController.text = company.name ?? '';
    managerNameController.text = company.managerName ?? '';
    managerEmailController.text = company.managerEmail ?? '';
    managerPhoneController.text = company.managerPhone ?? '';
  }

  void clearCompanyFields() {
    nameController.clear();
    managerNameController.clear();
    managerEmailController.clear();
    managerPhoneController.clear();
  }

  void openEditPopup(String title, Company? company) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormCompany(
          title: title,
          company: company,
        ),
      ),
    );
  }

  void searchCompanies(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredCompanies.value = companies;
    } else {
      filteredCompanies.value = companies
          .where((company) =>
              '${company.name?.toLowerCase()} ${company.name?.toLowerCase()} ${company.managerName}}'
                  .contains(query.toLowerCase()))
          .toList();
    }
  }
}
