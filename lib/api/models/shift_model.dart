class ShiftModel {
  List<Shift>? shifts;
  int? totalCount;
  int? pageCount;

  ShiftModel({this.shifts, this.totalCount, this.pageCount});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      shifts = <Shift>[];
      json['results'].forEach((v) {
        shifts!.add(Shift.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shifts != null) {
      data['results'] = shifts!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Shift {
  int? id;
  int? companyId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? createUserId;
  int? updateUserId;

  Shift({
    this.id,
    this.companyId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.createUserId,
    this.updateUserId,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      companyId: json['companyId'] ?? 0,
      name: json['name'] ?? "",
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
      if (name != null) 'name': name,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (createUserId != null) 'createUserId': createUserId!,
      if (updateUserId != null) 'updateUserId': updateUserId!,
    };
  }
}
