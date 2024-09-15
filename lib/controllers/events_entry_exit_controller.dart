import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_provider.dart';
import '../api/models/company_model.dart';
import '../api/models/users_entry_exit_event_model.dart';

class EventsEntryExitController extends GetxController {
  final ScrollController scrollController = ScrollController();

  var companies = <Company>[].obs;

  RxString entryTime = ''.obs;
  RxString exitTime = ''.obs;
  RxString workingHours = ''.obs;
  RxList lastEntryExit = [].obs;

  @override
  void onInit() {
    super.onInit();
    getLastEntryExit();
  }

  void getLastEntryExit() async {
    try {
      var body = {
        "limit": 10,
        "orders": [
          {
            "fieldName": "Id",
            "direction": "ASC",
          }
        ],
        "filters": []
      };
      var lastEntryExitModel = await ApiProvider()
          .usersEntryExitEventService
          .getLastEntryExitEvents(body);

      lastEntryExit.value = lastEntryExitModel.results!;

      for (UsersEntryExitEvent value in lastEntryExit) {
        DateTime parsedEntryDateTime =
            DateTime.parse(value.entry!.eventTime.toString());

        entryTime.value =
            "${parsedEntryDateTime.hour.toString().padLeft(2, '0')}:${parsedEntryDateTime.minute.toString().padLeft(2, '0')}";
        value.entry!.eventTime = entryTime.value;

        DateTime parsedExitDateTime =
            DateTime.parse(value.exit!.eventTime.toString());

        exitTime.value =
            "${parsedExitDateTime.hour.toString().padLeft(2, '0')}:${parsedExitDateTime.minute.toString().padLeft(2, '0')}";

        value.exit!.eventTime = exitTime.value;
      }
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

  void deleteCompany(Company company) async {
    try {
      await ApiProvider().companyService.deleteCompany(company);

      fetchCompanies();
    } catch (e) {
      print("Hata: $e");
    }
  }
}
