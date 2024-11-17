class UserRoleActionsModel {
  String? grup;
  List<String>? actions;

  UserRoleActionsModel({
    this.grup,
    this.actions,
  });

  UserRoleActionsModel.fromJson(Map<String, dynamic> json) {
    grup = json['grup'];
    actions = json['actions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grup'] = grup;
    data['actions'] = actions;
    return data;
  }
}
