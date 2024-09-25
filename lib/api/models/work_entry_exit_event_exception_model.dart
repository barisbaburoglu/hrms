class WorkEntryExitEventExceptionModel {
  List<WorkEntryExitEventException>? workEntryExitEventExceptions;
  int? totalCount;
  int? pageCount;

  WorkEntryExitEventExceptionModel(
      {this.workEntryExitEventExceptions, this.totalCount, this.pageCount});

  WorkEntryExitEventExceptionModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      workEntryExitEventExceptions = <WorkEntryExitEventException>[];
      json['results'].forEach((v) {
        workEntryExitEventExceptions!
            .add(WorkEntryExitEventException.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (workEntryExitEventExceptions != null) {
      data['results'] =
          workEntryExitEventExceptions!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class WorkEntryExitEventException {
  int? id;
  int? employeeId;
  int? qrCodeSettingId;
  String? reason;
  int? status;
  String? eventTime;
  int? eventType;
  int? qrCodeSetting;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  WorkEntryExitEventException(
      {this.id,
      this.employeeId,
      this.qrCodeSettingId,
      this.reason,
      this.status,
      this.eventTime,
      this.eventType,
      this.qrCodeSetting,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  WorkEntryExitEventException.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    qrCodeSettingId = json['qrCodeSettingId'];
    reason = json['reason'];
    status = json['status'];
    eventTime = json['eventTime'];
    eventType = json['eventType'];
    qrCodeSetting = json['qrCodeSetting'];
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (employeeId != null) {
      data['employeeId'] = employeeId;
    }
    if (qrCodeSettingId != null) {
      data['qrCodeSettingId'] = qrCodeSettingId;
    }
    if (reason != null) {
      data['reason'] = reason;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (eventTime != null) {
      data['eventTime'] = eventTime;
    }
    if (eventType != null) {
      data['eventType'] = eventType;
    }
    if (qrCodeSetting != null) {
      data['qrCodeSetting'] = qrCodeSetting;
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (createUserID != null) {
      data['createUserID'] = createUserID;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt;
    }
    if (updateUserID != null) {
      data['updateUserID'] = updateUserID;
    }
    return data;
  }
}
