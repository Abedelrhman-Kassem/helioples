class Alerts {
  String? id;
  String? type;
  String? title;
  String? description;
  String? icon;
  String? route;
  bool? isRead;
  String? topic;
  String? userId;
  String? user;
  String? eventKey;
  String? dataJson;
  String? targetId;
  String? sentAt;
  String? readAt;
  String? createdAt;

  Alerts({
    this.id,
    this.type,
    this.title,
    this.description,
    this.icon,
    this.route,
    this.isRead,
    this.topic,
    this.userId,
    this.user,
    this.eventKey,
    this.dataJson,
    this.targetId,
    this.sentAt,
    this.readAt,
    this.createdAt,
  });

  Alerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    route = json['route'];
    isRead = json['isRead'];
    topic = json['topic'];
    userId = json['userId'];
    user = json['user'];
    eventKey = json['eventKey'];
    dataJson = json['dataJson'];
    targetId = json['targetId'];
    sentAt = json['sentAt'];
    readAt = json['readAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['route'] = route;
    data['isRead'] = isRead;
    data['topic'] = topic;
    data['userId'] = userId;
    data['user'] = user;
    data['eventKey'] = eventKey;
    data['dataJson'] = dataJson;
    data['targetId'] = targetId;
    data['sentAt'] = sentAt;
    data['readAt'] = readAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
