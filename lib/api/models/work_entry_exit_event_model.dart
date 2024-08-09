class WorkEntryExitEvent {
  int? id;
  int? employeeId;
  int? qrCodeSettingId;
  double? locationLatitude;
  double? locationLongitude;
  DateTime? eventTime;
  int? eventType;
  int? createUserId;
  DateTime? updatedAt;
  int? updateUserId;

  WorkEntryExitEvent({
    this.id,
    this.employeeId,
    this.qrCodeSettingId,
    this.locationLatitude,
    this.locationLongitude,
    this.eventTime,
    this.eventType,
    this.createUserId,
    this.updatedAt,
    this.updateUserId,
  });

  factory WorkEntryExitEvent.fromJson(Map<String, dynamic> json) {
    return WorkEntryExitEvent(
      id: json['Id'],
      employeeId: json['EmployeeId'],
      qrCodeSettingId: json['QRCodeSettingId'],
      locationLatitude: json['LocationLatitude'],
      locationLongitude: json['LocationLongitude'],
      eventTime:
          json['EventTime'] != null ? DateTime.parse(json['EventTime']) : null,
      eventType: json['EventType'],
      createUserId: json['CreateUserID'],
      updatedAt:
          json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      updateUserId: json['UpdateUserID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'EmployeeId': employeeId,
      'QRCodeSettingId': qrCodeSettingId,
      'LocationLatitude': locationLatitude,
      'LocationLongitude': locationLongitude,
      'EventTime': eventTime?.toIso8601String(),
      'EventType': eventType,
      'CreateUserID': createUserId,
      'UpdatedAt': updatedAt?.toIso8601String(),
      'UpdateUserID': updateUserId,
    };
  }
}
