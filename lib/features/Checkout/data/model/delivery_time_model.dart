class DeliveryTimeModel {
  List<AvailableTime>? available;

  DeliveryTimeModel({this.available});

  DeliveryTimeModel.fromJson(Map<String, dynamic> json) {
    if (json['available'] != null) {
      available = <AvailableTime>[];
      json['available'].forEach((v) {
        available!.add(AvailableTime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (available != null) {
      data['available'] = available!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableTime {
  int? id;
  String? from;
  String? to;

  AvailableTime({this.id, this.from, this.to});

  AvailableTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
