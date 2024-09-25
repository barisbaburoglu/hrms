class UserInfo {
  int? id;
  int? employeeId;
  String? name;
  String? surname;
  String? email;
  int? employeeNumber;

  UserInfo(
      {this.id,
      this.employeeId,
      this.name,
      this.surname,
      this.email,
      this.employeeNumber});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    employeeNumber = json['employeeNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (employeeId != null) {
      data['employeeId'] = employeeId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (surname != null) {
      data['surname'] = surname;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (employeeNumber != null) {
      data['employeeNumber'] = employeeNumber;
    }
    return data;
  }
}
