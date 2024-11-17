class WeeklyShiftGroupedModel {
  String? employeeName;
  int? employeeNumber;
  String? shiftName;
  List<Days>? days;

  WeeklyShiftGroupedModel({
    this.employeeName,
    this.employeeNumber,
    this.shiftName,
    this.days,
  });

  WeeklyShiftGroupedModel.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    employeeNumber = json['employeeNumber'];
    shiftName = json['shiftName'];
    if (json['shifts'] != null) {
      days = <Days>[];
      json['shifts'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeName'] = employeeName;
    data['employeeNumber'] = employeeNumber;
    data['shiftName'] = shiftName;
    if (days != null) {
      data['shifts'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int? weeklyEmployeeShiftId;
  int? shiftId;
  int? shiftDayOfWeek;
  int? shiftDayType;
  int? shiftDuration;
  String? shiftStartTime;
  String? shiftEndTime;

  Days(
      {this.weeklyEmployeeShiftId,
      this.shiftId,
      this.shiftDayOfWeek,
      this.shiftDayType,
      this.shiftDuration,
      this.shiftStartTime,
      this.shiftEndTime});

  Days.fromJson(Map<String, dynamic> json) {
    weeklyEmployeeShiftId = json['weeklyEmployeeShiftId'];
    shiftId = json['shiftId'];
    shiftDayOfWeek = json['shiftDayOfWeek'];
    shiftDayType = json['shiftDayType'];
    shiftDuration = json['shiftDuration'];
    shiftStartTime = json['shiftStartTime'];
    shiftEndTime = json['shiftEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weeklyEmployeeShiftId'] = weeklyEmployeeShiftId;
    data['shiftId'] = shiftId;
    data['shiftDayOfWeek'] = shiftDayOfWeek;
    data['shiftDayType'] = shiftDayType;
    data['shiftDuration'] = shiftDuration;
    data['shiftStartTime'] = shiftStartTime;
    data['shiftEndTime'] = shiftEndTime;
    return data;
  }
}
