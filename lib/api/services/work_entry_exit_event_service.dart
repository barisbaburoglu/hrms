import 'dart:convert';

import '../models/work_entry_exit_event_model.dart';
import 'api_service.dart';

class WorkEntryExitEventService {
  final ApiService apiService;

  WorkEntryExitEventService(this.apiService);

  Future<List<WorkEntryExitEventModel>> fetchWorkEntryExitEvents() async {
    final response = await apiService.getRequest('WorkEntryExitEventService',
        'PostEntryExit', '/WorkEntryExitEventServices/EntryExit');
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => WorkEntryExitEventModel.fromJson(json)).toList();
  }

  Future<void> createWorkEntryExitEvent(
      WorkEntryExitEvent workEntryExitEvent) async {
    await apiService.postRequest('WorkEntryExitEventService', 'PostEntryExit',
        '/WorkEntryExitEventServices/EntryExit', workEntryExitEvent.toJson());
  }

  Future<void> patchEventStatus(int id, int status) async {
    await apiService.patchRequest(
        'WorkEntryExitEventExceptionService',
        'PatchWorkEntryExitEventException',
        '/WorkEntryExitEventExceptionServices/$id',
        {"Status": status});
  }
}
