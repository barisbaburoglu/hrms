class WorkEntryExitEventModel {
  List<WorkEntryExitEvent>? workEntryExitEvents;
  int? totalCount;
  int? pageCount;

  WorkEntryExitEventModel({
    this.workEntryExitEvents,
    this.totalCount,
    this.pageCount,
  });

  WorkEntryExitEventModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      workEntryExitEvents = <WorkEntryExitEvent>[];
      json['results'].forEach((v) {
        workEntryExitEvents!.add(WorkEntryExitEvent.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (workEntryExitEvents != null) {
      data['results'] = workEntryExitEvents!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class WorkEntryExitEvent {
  String? uniqueKey;
  double? locationLatitude;
  double? locationLongitude;

  WorkEntryExitEvent({
    this.uniqueKey,
    this.locationLatitude,
    this.locationLongitude,
  });

  WorkEntryExitEvent.fromJson(Map<String, dynamic> json) {
    uniqueKey = json['uniqueKey'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uniqueKey != null) {
      data['uniqueKey'] = uniqueKey;
    }
    if (locationLatitude != null) {
      data['locationLatitude'] = locationLatitude;
    }
    if (locationLongitude != null) {
      data['locationLongitude'] = locationLongitude;
    }
    return data;
  }
}
