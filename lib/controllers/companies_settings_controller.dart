import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/billing_information_model.dart';
import 'package:hrms/widgets/edit_form_company.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';

class CompaniesSettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController managerPhoneController = TextEditingController();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController taxOfficeController = TextEditingController();

  var companies = <Company>[].obs;

  Rxn<BillingInformation> billingInformation = Rxn<BillingInformation>();

  Rxn<Company> companyInformation = Rxn<Company>();

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
    fetchCompanyById(1);
    fetchBillingInformationById(1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchCompanies() async {
    try {
      var companyModel = await ApiProvider().companyService.fetchCompanies();
      companies.value = companyModel.companies ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchCompanyById(int id) async {
    try {
      companyInformation.value =
          await ApiProvider().companyService.fetchCompanyById(id);

      setCompanyFields(companyInformation.value!);
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchBillingInformationById(int id) async {
    try {
      billingInformation.value = await ApiProvider()
          .billingInformationService
          .fetchBillingInformationById(id);

      setBillingFields(billingInformation.value!);
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

  void setBillingFields(BillingInformation billing) {
    businessNameController.text = billing.businessName ?? "";
    addressController.text = billing.address ?? "";
    districtController.text = billing.district ?? "";
    cityController.text = billing.city ?? "";
    taxNumberController.text = billing.taxOrIdentificationNumber ?? "";
    taxOfficeController.text = billing.taxOffice ?? "";
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
}
