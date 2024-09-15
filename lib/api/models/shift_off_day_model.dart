class ShiftOffDayModel {
  List<ShiftOffDay>? shiftOffDays;
  int? totalCount;
  int? pageCount;

  ShiftOffDayModel({this.shiftOffDays, this.totalCount, this.pageCount});

  ShiftOffDayModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      shiftOffDays = <ShiftOffDay>[];
      json['results'].forEach((v) {
        shiftOffDays!.add(ShiftOffDay.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shiftOffDays != null) {
      data['results'] = shiftOffDays!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class ShiftOffDay {
  int? id;
  int? employeeId;
  int? dayOfWeek;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  String? updateUserID;

  ShiftOffDay(
      {this.id,
      this.employeeId,
      this.dayOfWeek,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  ShiftOffDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    dayOfWeek = json['dayOfWeek'];
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['dayOfWeek'] = dayOfWeek;
    data['createdAt'] = createdAt;
    data['createUserID'] = createUserID;
    data['updatedAt'] = updatedAt;
    data['updateUserID'] = updateUserID;
    return data;
  }
}
