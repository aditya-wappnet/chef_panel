class NotificationModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<NotificationData>? notificationData;

  NotificationModel(
      {this.count, this.next, this.previous, this.notificationData});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        notificationData: List<NotificationData>.from(
            json["results"].map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (notificationData != null) {
      data['results'] = notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  int? user;
  String? userName;
  String? title;
  String? body;
  String? createdAt;
  bool? readStatus;

  NotificationData(
      {this.id,
      this.user,
      this.userName,
      this.title,
      this.body,
      this.createdAt,
      this.readStatus});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
          id: json['id'],
          user: json['user'],
          userName: json['user_name'],
          title: json['title'],
          body: json['body'],
          createdAt: json['created_at'],
          readStatus: json['read_status']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['user_name'] = userName;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['read_status'] = readStatus;
    return data;
  }
}
