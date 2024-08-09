class DepartmentModel {
  List<Department>? departments;
  int? totalCount;
  int? pageCount;

  DepartmentModel({this.departments, this.totalCount, this.pageCount});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      departments = <Department>[];
      json['results'].forEach((v) {
        departments!.add(new Department.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (departments != null) {
      data['results'] = departments!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Department {
  int? id;
  int? companyId;
  String? name;
  String? description;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  Department(
      {this.id,
      this.companyId,
      this.name,
      this.description,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    name = json['name'];
    description = json['description'];
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
    if (name != null) {
      data['name'] = name;
    }
    if (description != null) {
      data['description'] = description;
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
