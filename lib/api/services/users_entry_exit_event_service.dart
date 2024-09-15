import 'dart:convert';

import '../models/users_entry_exit_event_model.dart';
import 'api_service.dart';

class UsersEntryExitEventService {
  final ApiService apiService;

  UsersEntryExitEventService(this.apiService);

  Future<UsersEntryExitEventsModel> getLastEntryExitEvents(
      Map<String, dynamic> body) async {
    final response = await apiService.postRequest(
        '/WorkEntryExitEventServices/UsersEntryExitEvents', body);
    var data = json.decode(response.body);
    return UsersEntryExitEventsModel.fromJson(data);
  }
}
