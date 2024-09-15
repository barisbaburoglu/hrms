class ShiftDayModel {
  List<ShiftDay>? shiftDays;
  int? totalCount;
  int? pageCount;

  ShiftDayModel({this.shiftDays, this.totalCount, this.pageCount});

  ShiftDayModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      shiftDays = <ShiftDay>[];
      json['results'].forEach((v) {
        shiftDays!.add(ShiftDay.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shiftDays != null) {
      data['results'] = shiftDays!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class ShiftDay {
  int? id;
  int? companyId;
  int? shiftId;
  String? startTime;
  String? endTime;
  bool? isOffDay;
  int? dayOfWeek;
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? createUserId;
  int? updateUserId;

  ShiftDay({
    this.id,
    this.companyId,
    this.shiftId,
    this.startTime,
    this.endTime,
    this.isOffDay,
    this.dayOfWeek,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.createUserId,
    this.updateUserId,
  });

  factory ShiftDay.fromJson(Map<String, dynamic> json) {
    return ShiftDay(
      id: json['id'],
      companyId: json['companyId'] ?? 0,
      shiftId: json['shiftId'] ?? 0,
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      isOffDay: json['isOffDay'] ?? false,
      dayOfWeek: json['dayOfWeek'] ?? 0,
      duration: json['duration'] ?? 9,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['updatedAt']),
      createUserId: json['createUserId'] ?? 0,
      updateUserId: json['updateUserId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (companyId != null) 'companyId': companyId,
      if (shiftId != null) 'shiftId': shiftId,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (isOffDay != null) 'isOffDay': isOffDay,
      if (dayOfWeek != null) 'dayOfWeek': dayOfWeek,
      if (duration != null) 'dayOfWeek': duration,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (createUserId != null) 'createUserId': createUserId!,
      if (updateUserId != null) 'updateUserId': updateUserId!,
    };
  }

  ShiftDay copyWith({
    int? id,
    int? companyId,
    int? shiftId,
    String? startTime,
    String? endTime,
    bool? isOffDay,
    int? dayOfWeek,
    int? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShiftDay(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      shiftId: shiftId ?? this.shiftId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isOffDay: isOffDay ?? this.isOffDay,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
