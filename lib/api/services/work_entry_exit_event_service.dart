import 'dart:convert';

import '../models/work_entry_exit_event_model.dart';
import 'api_service.dart';

class WorkEntryExitEventService {
  final ApiService apiService;

  WorkEntryExitEventService(this.apiService);

  Future<List<WorkEntryExitEventModel>> fetchWorkEntryExitEvents() async {
    final response =
        await apiService.getRequest('/WorkEntryExitEventServices/EntryExit');
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => WorkEntryExitEventModel.fromJson(json)).toList();
  }

  Future<void> createWorkEntryExitEvent(
      WorkEntryExitEvent workEntryExitEvent) async {
    await apiService.postRequest(
        '/WorkEntryExitEventServices/EntryExit', workEntryExitEvent.toJson());
  }

  Future<void> patchEventStatus(int id, int status) async {
    await apiService.patchRequest(
        '/WorkEntryExitEventExceptionServices/$id', {"Status": status});
  }
}
