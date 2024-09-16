class LeaveModel {
  List<Leave>? leaves;
  int? totalCount;
  int? pageCount;

  LeaveModel({this.leaves, this.totalCount, this.pageCount});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      leaves = <Leave>[];
      json['results'].forEach((v) {
        leaves!.add(Leave.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaves != null) {
      data['results'] = leaves!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Leave {
  int? id;
  int? companyId;
  int? employeeId;
  String? startDate;
  String? endDate;
  int? leaveType;
  String? reason;
  int? status;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  Leave(
      {this.id,
      this.companyId,
      this.employeeId,
      this.startDate,
      this.endDate,
      this.leaveType,
      this.reason,
      this.status,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  Leave.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    employeeId = json['employeeId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    leaveType = json['leaveType'];
    reason = json['reason'];
    status = json['status'];
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) data['id'] = id;
    if (companyId != null) data['companyId'] = companyId;
    if (employeeId != null) data['employeeId'] = employeeId;
    if (startDate != null) data['startDate'] = startDate;
    if (endDate != null) data['endDate'] = endDate;
    if (leaveType != null) data['leaveType'] = leaveType;
    if (reason != null) data['reason'] = reason;
    if (status != null) data['status'] = status;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (createUserID != null) data['createUserID'] = createUserID;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    if (updateUserID != null) data['updateUserID'] = updateUserID;
    return data;
  }
}
