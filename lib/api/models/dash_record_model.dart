import 'package:intl/intl.dart';

class DashRecordModel {
  List<RecordEmployees>? presentEmployees;
  List<RecordEmployees>? lateEmployees;
  List<RecordEmployees>? absentEmployees;
  List<RecordEmployees>? employeesOnLeave;

  DashRecordModel({
    this.presentEmployees,
    this.lateEmployees,
    this.absentEmployees,
    this.employeesOnLeave,
  });

  DashRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['presentEmployees'] != null) {
      presentEmployees = List<RecordEmployees>.from(
        json['presentEmployees'].map((v) => RecordEmployees.fromJson(v)),
      );
    }
    if (json['lateEmployees'] != null) {
      lateEmployees = List<RecordEmployees>.from(
        json['lateEmployees'].map((v) => RecordEmployees.fromJson(v)),
      );
    }
    if (json['absentEmployees'] != null) {
      absentEmployees = List<RecordEmployees>.from(
        json['absentEmployees'].map((v) => RecordEmployees.fromJson(v)),
      );
    }
    if (json['employeesOnLeave'] != null) {
      employeesOnLeave = List<RecordEmployees>.from(
        json['employeesOnLeave'].map((v) => RecordEmployees.fromJson(v)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (presentEmployees != null) {
      data['presentEmployees'] =
          presentEmployees!.map((v) => v.toJson()).toList();
    }
    if (lateEmployees != null) {
      data['lateEmployees'] = lateEmployees!.map((v) => v.toJson()).toList();
    }
    if (absentEmployees != null) {
      data['absentEmployees'] =
          absentEmployees!.map((v) => v.toJson()).toList();
    }
    if (employeesOnLeave != null) {
      data['employeesOnLeave'] =
          employeesOnLeave!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecordEmployees {
  String? employee;
  String? eventTime;
  String? shiftStart;
  String? shiftEnd;

  RecordEmployees({
    this.employee,
    this.eventTime,
    this.shiftStart,
    this.shiftEnd,
  });

  RecordEmployees.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] ?? "";
    eventTime = getFormattedEventTime(json['eventTime']);
    shiftStart = getformatTime(json['shiftStart']);
    shiftEnd = getformatTime(json['shiftEnd']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee'] = employee;
    data['eventTime'] = eventTime;
    data['shiftStart'] = shiftStart;
    data['shiftEnd'] = shiftEnd;
    return data;
  }

  /// Event ve shift saatlerini formatla
  String getFormattedEventTime(String? eventTime) {
    if (eventTime != null && eventTime != "0001-01-01T00:00:00") {
      final DateTime parsedTime = DateTime.parse(eventTime);
      return DateFormat.Hm().format(parsedTime);
    }
    return "N/A";
  }

  /// Yardımcı metot: Saatleri formatla
  String getformatTime(String? time) {
    if (time != null && time != "00:00:00") {
      final DateTime parsedTime = DateFormat.Hms().parse(time);
      return DateFormat.Hm().format(parsedTime);
    }
    return "N/A";
  }
}
