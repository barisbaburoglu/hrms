class QRCodeSettingModel {
  List<QRCodeSetting>? qrCodeSettings;
  int? totalCount;
  int? pageCount;

  QRCodeSettingModel({this.qrCodeSettings, this.totalCount, this.pageCount});

  QRCodeSettingModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      qrCodeSettings = <QRCodeSetting>[];
      json['results'].forEach((v) {
        qrCodeSettings!.add(QRCodeSetting.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (qrCodeSettings != null) {
      data['results'] = qrCodeSettings!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class QRCodeSetting {
  int? id;
  int? companyId;
  String? uniqueKey;
  String? name;
  int? eventType;
  int? locationRadius;
  double? locationLatitude;
  double? locationLongitude;
  bool? enableOutOfLocation;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  QRCodeSetting(
      {this.id,
      this.companyId,
      this.uniqueKey,
      this.name,
      this.eventType,
      this.locationRadius,
      this.locationLatitude,
      this.locationLongitude,
      this.enableOutOfLocation,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  QRCodeSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    uniqueKey = json['uniqueKey'];
    name = json['name'];
    eventType = json['eventType'];
    locationRadius = json['locationRadius'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
    enableOutOfLocation = json['enableOutOfLocation'];
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
    if (companyId != null) {
      data['companyId'] = companyId;
    }
    if (uniqueKey != null) {
      data['uniqueKey'] = uniqueKey;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (eventType != null) {
      data['eventType'] = eventType;
    }
    if (locationRadius != null) {
      data['locationRadius'] = locationRadius;
    }
    if (locationLatitude != null) {
      data['locationLatitude'] = locationLatitude;
    }
    if (locationLongitude != null) {
      data['locationLongitude'] = locationLongitude;
    }
    if (enableOutOfLocation != null) {
      data['enableOutOfLocation'] = enableOutOfLocation;
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
