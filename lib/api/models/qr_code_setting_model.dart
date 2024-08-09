class QRCodeSetting {
  int? id;
  int? companyId;
  String name;
  int locationRadius;
  double locationLatitude;
  double locationLongitude;
  bool enableOutOfLocation;
  DateTime createdAt;
  int? createUserId;
  DateTime? updatedAt;
  int? updateUserId;

  QRCodeSetting({
    this.id,
    this.companyId,
    required this.name,
    required this.locationRadius,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.enableOutOfLocation,
    required this.createdAt,
    this.createUserId,
    this.updatedAt,
    this.updateUserId,
  });

  factory QRCodeSetting.fromJson(Map<String, dynamic> json) {
    return QRCodeSetting(
      id: json['Id'],
      companyId: json['CompanyId'],
      name: json['Name'],
      locationRadius: json['LocationRadius'],
      locationLatitude: json['LocationLatitude'],
      locationLongitude: json['LocationLongitude'],
      enableOutOfLocation: json['EnableOutOfLocation'],
      createdAt: DateTime.parse(json['CreatedAt']),
      createUserId: json['CreateUserID'],
      updatedAt:
          json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      updateUserId: json['UpdateUserID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'CompanyId': companyId,
      'Name': name,
      'LocationRadius': locationRadius,
      'LocationLatitude': locationLatitude,
      'LocationLongitude': locationLongitude,
      'EnableOutOfLocation': enableOutOfLocation,
      'CreatedAt': createdAt.toIso8601String(),
      'CreateUserID': createUserId,
      'UpdatedAt': updatedAt?.toIso8601String(),
      'UpdateUserID': updateUserId,
    };
  }
}
