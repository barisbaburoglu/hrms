class CompanyModel {
  List<Company>? companies;
  int? totalCount;
  int? pageCount;

  CompanyModel({this.companies, this.totalCount, this.pageCount});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      companies = <Company>[];
      json['results'].forEach((v) {
        companies!.add(Company.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (companies != null) {
      data['results'] = companies!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? managerName;
  String? managerEmail;
  String? managerPhone;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  Company(
      {this.id,
      this.name,
      this.managerName,
      this.managerEmail,
      this.managerPhone,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    managerName = json['managerName'];
    managerEmail = json['managerEmail'];
    managerPhone = json['managerPhone'];
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (managerName != null) data['managerName'] = managerName;
    if (managerEmail != null) data['managerEmail'] = managerEmail;
    if (managerPhone != null) data['managerPhone'] = managerPhone;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (createUserID != null) data['createUserID'] = createUserID;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    if (updateUserID != null) data['updateUserID'] = updateUserID;
    return data;
  }
}
