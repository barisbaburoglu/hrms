import 'qr_code_setting_model.dart';

class UsersEntryExitEventsModel {
  List<UsersEntryExitEvent>? results;
  int? totalCount;
  int? pageCount;

  UsersEntryExitEventsModel({this.results, this.totalCount, this.pageCount});

  UsersEntryExitEventsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <UsersEntryExitEvent>[];
      json['results'].forEach((v) {
        results!.add(UsersEntryExitEvent.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class UsersEntryExitEvent {
  int? id;
  int? employeeId;
  int? entryId;
  int? exceptionEntryId;
  int? exitId;
  int? exceptionExitId;
  EntryExit? entry;
  EntryExit? exit;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  UsersEntryExitEvent(
      {this.id,
      this.employeeId,
      this.entryId,
      this.exceptionEntryId,
      this.exitId,
      this.exceptionExitId,
      this.entry,
      this.exit,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  UsersEntryExitEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    entryId = json['entryId'];
    exceptionEntryId = json['exceptionEntryId'];
    exitId = json['exitId'];
    exceptionExitId = json['exceptionExitId'];
    entry = json['entry'] != null ? EntryExit.fromJson(json['entry']) : null;
    exit = json['exit'] != null ? EntryExit.fromJson(json['exit']) : null;
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['entryId'] = entryId;
    data['exceptionEntryId'] = exceptionEntryId;
    data['exitId'] = exitId;
    data['exceptionExitId'] = exceptionExitId;
    if (entry != null) {
      data['entry'] = entry!.toJson();
    }
    if (exit != null) {
      data['exit'] = exit!.toJson();
    }
    data['createdAt'] = createdAt;
    data['createUserID'] = createUserID;
    data['updatedAt'] = updatedAt;
    data['updateUserID'] = updateUserID;
    return data;
  }
}

class EntryExit {
  int? id;
  int? employeeId;
  int? qrCodeSettingId;
  double? locationLatitude;
  double? locationLongitude;
  String? eventTime;
  int? eventType;
  QRCodeSetting? qrCodeSetting;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  EntryExit(
      {this.id,
      this.employeeId,
      this.qrCodeSettingId,
      this.locationLatitude,
      this.locationLongitude,
      this.eventTime,
      this.eventType,
      this.qrCodeSetting,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  EntryExit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    qrCodeSettingId = json['qrCodeSettingId'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
    eventTime = json['eventTime'];
    eventType = json['eventType'];
    qrCodeSetting = json['qrCodeSetting'] != null
        ? QRCodeSetting.fromJson(json['qrCodeSetting'])
        : null;
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['qrCodeSettingId'] = qrCodeSettingId;
    data['locationLatitude'] = locationLatitude;
    data['locationLongitude'] = locationLongitude;
    data['eventTime'] = eventTime;
    data['eventType'] = eventType;
    if (qrCodeSetting != null) {
      data['qrCodeSetting'] = qrCodeSetting!.toJson();
    }
    data['createdAt'] = createdAt;
    data['createUserID'] = createUserID;
    data['updatedAt'] = updatedAt;
    data['updateUserID'] = updateUserID;
    return data;
  }
}
