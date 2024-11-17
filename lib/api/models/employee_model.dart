import 'shift_off_day_model.dart';

class EmployeeModel {
  List<Employee>? employees;
  int? totalCount;
  int? pageCount;

  EmployeeModel({this.employees, this.totalCount, this.pageCount});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      employees = <Employee>[];
      json['results'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employees != null) {
      data['results'] = employees!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Employee {
  int? id;
  int? companyId;
  int? employeeTypeId;
  int? departmentId;
  int? shiftId;
  int? employeeNumber;
  String? name;
  String? surname;
  String? employmentDate;
  String? email;
  String? phone;
  List<ShiftOffDay>? employeeShiftDayOffs;
  List<IdentityUserRoles>? identityUserRoles;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  Employee(
      {this.id,
      this.companyId,
      this.employeeTypeId,
      this.departmentId,
      this.shiftId,
      this.employeeNumber,
      this.name,
      this.surname,
      this.employmentDate,
      this.email,
      this.phone,
      this.identityUserRoles,
      this.employeeShiftDayOffs,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    employeeTypeId = json['employeeTypeId'];
    departmentId = json['departmentId'];
    shiftId = json['shiftId'];
    employeeNumber = json['employeeNumber'];
    name = json['name'];
    surname = json['surname'];
    employmentDate = json['employmentDate'];
    email = json['email'];
    phone = json['phone'];
    if (json['employeeShiftDayOffs'] != null) {
      employeeShiftDayOffs = <ShiftOffDay>[];
      json['employeeShiftDayOffs'].forEach((v) {
        employeeShiftDayOffs!.add(ShiftOffDay.fromJson(v));
      });
    }
    if (json['identityUserRoles'] != null) {
      identityUserRoles = <IdentityUserRoles>[];
      json['identityUserRoles'].forEach((v) {
        identityUserRoles!.add(new IdentityUserRoles.fromJson(v));
      });
    }
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
    if (employeeTypeId != null) {
      data['employeeTypeId'] = employeeTypeId;
    }
    if (departmentId != null) {
      data['departmentId'] = departmentId;
    }
    if (shiftId != null) {
      data['shiftId'] = shiftId;
    }
    if (employeeNumber != null) {
      data['employeeNumber'] = employeeNumber;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (surname != null) {
      data['surname'] = surname;
    }
    if (employmentDate != null) {
      data['employmentDate'] = employmentDate;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (employeeShiftDayOffs != null) {
      data['employeeShiftDayOffs'] =
          employeeShiftDayOffs!.map((v) => v.toJson()).toList();
    }

    if (this.identityUserRoles != null) {
      data['identityUserRoles'] =
          this.identityUserRoles!.map((v) => v.toJson()).toList();
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

class IdentityUserRoles {
  Null? companyId;
  int? userId;
  int? roleId;

  IdentityUserRoles({this.companyId, this.userId, this.roleId});

  IdentityUserRoles.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    userId = json['userId'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['userId'] = this.userId;
    data['roleId'] = this.roleId;
    return data;
  }
}
