class RoleActionModel {
  int? id;
  int? roleId;
  String? actionGroup;
  String? actionName;

  RoleActionModel({
    this.id,
    this.roleId,
    this.actionGroup,
    this.actionName,
  });

  RoleActionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['roleId'];
    actionGroup = json['actionGroup'];
    actionName = json['actionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (roleId != null) {
      data['roleId'] = roleId;
    }
    data['actionGroup'] = actionGroup;
    data['actionName'] = actionName;
    return data;
  }
}
