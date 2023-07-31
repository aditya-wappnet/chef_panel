class NotificationModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  NotificationModel({this.count, this.next, this.previous, this.results});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? user;
  String? userName;
  String? title;
  String? body;
  String? createdAt;
  bool? readStatus;

  Results(
      {this.id,
      this.user,
      this.userName,
      this.title,
      this.body,
      this.createdAt,
      this.readStatus});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userName = json['user_name'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    readStatus = json['read_status'];
  }

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
