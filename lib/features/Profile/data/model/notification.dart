class Alerts {
  int? id;
  String? type;
  String? title;
  String? description;
  bool? isRead;
  String? router;
  String? createdAt;
  int? userId;

  Alerts(
      {this.id,
      this.type,
      this.title,
      this.description,
      this.isRead,
      this.router,
      this.createdAt,
      this.userId});

  Alerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    isRead = json['isRead'];
    router = json['router'];
    createdAt = json['createdAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isRead'] = this.isRead;
    data['router'] = this.router;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    return data;
  }
}