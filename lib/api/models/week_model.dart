class WeekModel {
  int? weekId;
  String? startDate;
  String? endDate;

  WeekModel({
    this.weekId,
    this.startDate,
    this.endDate,
  });

  WeekModel.fromJson(Map<String, dynamic> json) {
    weekId = json['weekId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekId'] = weekId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
