class EmployeeRequestModel {
  List<EmployeeRequest>? employeeRequests;
  int? totalCount;
  int? pageCount;

  EmployeeRequestModel(
      {this.employeeRequests, this.totalCount, this.pageCount});

  EmployeeRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      employeeRequests = <EmployeeRequest>[];
      json['results'].forEach((v) {
        employeeRequests!.add(EmployeeRequest.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeRequests != null) {
      data['results'] = employeeRequests!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class EmployeeRequest {
  int? id;
  int? companyId;
  int? employeeId;
  String? subject;
  String? detail;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  EmployeeRequest(
      {this.id,
      this.companyId,
      this.employeeId,
      this.subject,
      this.detail,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  EmployeeRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'] ?? 0;
    employeeId = json['employeeId'] ?? 0;
    subject = json['subject'] ?? "";
    detail = json['detail'] ?? "";
    createdAt = json['createdAt'] ?? "";
    createUserID = json['createUserID'] ?? 0;
    updatedAt = json['updatedAt'] ?? "";
    updateUserID = json['updateUserID'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (companyId != null) {
      data['companyId'] = companyId;
    }
    if (employeeId != null) {
      data['employeeId'] = employeeId;
    }
    if (subject != null) {
      data['subject'] = subject;
    }
    if (detail != null) {
      data['detail'] = detail;
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
