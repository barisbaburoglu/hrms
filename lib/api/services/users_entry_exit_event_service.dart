import 'dart:convert';

import '../models/users_entry_exit_event_model.dart';
import '../models/work_entry_exit_event_exception_model.dart';
import 'api_service.dart';

class UsersEntryExitEventService {
  final ApiService apiService;

  UsersEntryExitEventService(this.apiService);

  Future<UsersEntryExitEventsModel> getLastEntryExitEvents(
      Map<String, dynamic> body) async {
    final response = await apiService.postRequest(
        'WorkEntryExitEventService',
        'PostUsersEntryExitEvents',
        '/WorkEntryExitEventServices/UsersEntryExitEvents',
        body);
    var data = json.decode(response.body);
    return UsersEntryExitEventsModel.fromJson(data);
  }

  Future<WorkEntryExitEventExceptionModel> getWorkEntryExitEventExceptions(
      Map<String, dynamic> body) async {
    final response = await apiService.postRequest('WorkEntryExitEventService',
        'PostEntryExit', '/WorkEntryExitEventExceptionServices/All', body);
    var data = json.decode(response.body);
    return WorkEntryExitEventExceptionModel.fromJson(data);
  }

  Future<WorkEntryExitEventException> createWorkEntryExitEventException(
      WorkEntryExitEventException workEntryExitEventException) async {
    final response = await apiService.postRequest(
        'WorkEntryExitEventExceptionService',
        'AddWorkEntryExitEventException',
        '/WorkEntryExitEventExceptionServices',
        workEntryExitEventException.toJson());
    var data = json.decode(response.body);
    return WorkEntryExitEventException.fromJson(data);
  }

  Future<WorkEntryExitEventException> updateWorkEntryExitEventException(
      WorkEntryExitEventException workEntryExitEventException) async {
    final response = await apiService.putRequest(
        'WorkEntryExitEventExceptionService',
        'UpdateWorkEntryExitEventException',
        '/WorkEntryExitEventExceptionServices',
        workEntryExitEventException.toJson());
    var data = json.decode(response.body);
    return WorkEntryExitEventException.fromJson(data);
  }
}
