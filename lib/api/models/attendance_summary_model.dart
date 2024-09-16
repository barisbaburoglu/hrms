import 'employee_model.dart';

class AttendanceSummary {
  StatusDetails present;
  StatusDetails late;
  StatusDetails absent;
  StatusDetails onLeave;
  StatusDetails leftEarly;
  List<DailyWorkCount> weeklyWorkCount;
  TotalEmployees totalEmployees;

  AttendanceSummary({
    required this.present,
    required this.late,
    required this.absent,
    required this.onLeave,
    required this.leftEarly,
    required this.weeklyWorkCount,
    required this.totalEmployees,
  });

  // JSON'den Model'e dönüştürme
  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    var workCountList = json['weeklyWorkCount'] as List;
    List<DailyWorkCount> workCount =
        workCountList.map((i) => DailyWorkCount.fromJson(i)).toList();

    return AttendanceSummary(
      present: StatusDetails.fromJson(json['present']),
      late: StatusDetails.fromJson(json['late']),
      absent: StatusDetails.fromJson(json['absent']),
      onLeave: StatusDetails.fromJson(json['onLeave']),
      leftEarly: StatusDetails.fromJson(json['leftEarly']),
      weeklyWorkCount: workCount,
      totalEmployees: TotalEmployees.fromJson(json['totalEmployees']),
    );
  }

  // Model'den JSON'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'present': present.toJson(),
      'late': late.toJson(),
      'absent': absent.toJson(),
      'onLeave': onLeave.toJson(),
      'leftEarly': leftEarly.toJson(),
      'weeklyWorkCount': weeklyWorkCount.map((e) => e.toJson()).toList(),
      'totalEmployees': totalEmployees.toJson(),
    };
  }
}

class StatusDetails {
  int totalCount;
  List<Employee> employees;

  StatusDetails({
    required this.totalCount,
    required this.employees,
  });

  // JSON'den Model'e dönüştürme
  factory StatusDetails.fromJson(Map<String, dynamic> json) {
    var employeeList = json['employees'] as List;
    List<Employee> employees =
        employeeList.map((i) => Employee.fromJson(i)).toList();

    return StatusDetails(
      totalCount: json['totalCount'],
      employees: employees,
    );
  }

  // Model'den JSON'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'employees': employees.map((e) => e.toJson()).toList(),
    };
  }
}

class DailyWorkCount {
  String date; // Tarih formatı: "YYYY-MM-DD"
  int numberOfEmployees;

  DailyWorkCount({
    required this.date,
    required this.numberOfEmployees,
  });

  // JSON'den Model'e dönüştürme
  factory DailyWorkCount.fromJson(Map<String, dynamic> json) {
    return DailyWorkCount(
      date: json['date'],
      numberOfEmployees: json['numberOfEmployees'],
    );
  }

  // Model'den JSON'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'numberOfEmployees': numberOfEmployees,
    };
  }
}

class TotalEmployees {
  int totalMen;
  int totalWomen;

  TotalEmployees({
    required this.totalMen,
    required this.totalWomen,
  });

  // JSON'den Model'e dönüştürme
  factory TotalEmployees.fromJson(Map<String, dynamic> json) {
    return TotalEmployees(
      totalMen: json['totalMen'],
      totalWomen: json['totalWomen'],
    );
  }

  // Model'den JSON'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'totalMen': totalMen,
      'totalWomen': totalWomen,
    };
  }
}
