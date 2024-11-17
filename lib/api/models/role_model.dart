class RoleModel {
  List<Role>? roles;
  int? totalCount;
  int? pageCount;

  RoleModel({this.roles, this.totalCount, this.pageCount});

  RoleModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      roles = <Role>[];
      json['results'].forEach((v) {
        roles!.add(new Role.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roles != null) {
      data['results'] = roles!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? normalizedName;
  String? concurrencyStamp;

  Role({
    this.id,
    this.name,
    this.normalizedName,
    this.concurrencyStamp,
  });

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    normalizedName = json['normalizedName'];
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['name'] = name;
    data['normalizedName'] = normalizedName;
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}


// class Permission {
//   final bool addAction;
//   final bool updateAction;
//   final bool deleteAction;

//   Permission({
//     required this.addAction,
//     required this.updateAction,
//     required this.deleteAction,
//   });

//   factory Permission.fromJson(Map<String, dynamic> json) {
//     return Permission(
//       addAction: json['AddAction'] ?? false,
//       updateAction: json['UpdateAction'] ?? false,
//       deleteAction: json['DeleteAction'] ?? false,
//     );
//   }
// }

// class UserInfo {
//   final int id;
//   final int employeeId;
//   final String name;
//   final String surname;
//   final String email;
//   final int employeeNumber;
//   final List<Role> roles;

//   UserInfo({
//     required this.id,
//     required this.employeeId,
//     required this.name,
//     required this.surname,
//     required this.email,
//     required this.employeeNumber,
//     required this.roles,
//   });

//   factory UserInfo.fromJson(Map<String, dynamic> json) {
//     List<Role> roles = [];
//     if (json['roles'] != null) {
//       json['roles'].forEach((role) {
//         role.forEach((roleName, permissions) {
//           roles.add(Role.fromJson(roleName, permissions));
//         });
//       });
//     }
//     return UserInfo(
//       id: json['id'],
//       employeeId: json['employeeId'],
//       name: json['name'],
//       surname: json['surname'],
//       email: json['email'],
//       employeeNumber: json['employeeNumber'],
//       roles: roles,
//     );
//   }

//   bool hasPermission(String roleName, String serviceName, String action) {
//     final role = roles.firstWhere((r) => r.roleName == roleName,
//         orElse: () => Role(roleName: '', services: {}));
//     final permission = role.services[serviceName];
//     if (permission != null) {
//       if (action == 'AddAction') return permission.addAction;
//       if (action == 'DeleteAction') return permission.deleteAction;
//     }
//     return false;
//   }
// }
