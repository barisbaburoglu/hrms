import 'dart:convert';

import '../models/work_entry_exit_event_model.dart';
import 'api_service.dart';

class WorkEntryExitEventService {
  final ApiService apiService;

  WorkEntryExitEventService(this.apiService);

  Future<List<WorkEntryExitEvent>> fetchWorkEntryExitEvents() async {
    final response = await apiService.getRequest('/work-entry-exit-events');
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => WorkEntryExitEvent.fromJson(json)).toList();
  }

  Future<WorkEntryExitEvent> fetchWorkEntryExitEventById(int id) async {
    final response = await apiService.getRequest('/work-entry-exit-events/$id');
    return WorkEntryExitEvent.fromJson(json.decode(response.body));
  }

  Future<void> createWorkEntryExitEvent(
      WorkEntryExitEvent workEntryExitEvent) async {
    await apiService.postRequest(
        '/work-entry-exit-events', workEntryExitEvent.toJson());
  }

  Future<void> updateWorkEntryExitEvent(
      WorkEntryExitEvent workEntryExitEvent) async {
    await apiService.putRequest(
        '/work-entry-exit-events/${workEntryExitEvent.id}',
        workEntryExitEvent.toJson());
  }

  Future<void> deleteWorkEntryExitEvent(int id) async {
    await apiService.deleteRequest('/work-entry-exit-events/$id');
  }
}
