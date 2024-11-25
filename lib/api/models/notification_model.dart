class NotificationModel {
  List<Notification>? notifications;
  int? totalCount;
  int? pageCount;

  NotificationModel({
    this.notifications,
    this.totalCount,
    this.pageCount,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      notifications = <Notification>[];
      json['results'].forEach((v) {
        notifications!.add(Notification.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['results'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class Notification {
  int? id;
  int? departmentId;
  String? title;
  String? body;

  Notification({
    this.id,
    this.departmentId,
    this.title,
    this.body,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['departmentId'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }

    if (departmentId != null) {
      data['departmentId'] = departmentId;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (body != null) {
      data['body'] = body;
    }

    return data;
  }
}
