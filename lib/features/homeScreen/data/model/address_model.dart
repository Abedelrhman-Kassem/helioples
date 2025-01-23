class AddressModel {
  List<Address>? address;

  AddressModel({this.address});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? locationStr;
  double? latitude;
  double? longitude;
  String? buildingNo;
  String? floor;
  String? street;
  String? department;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;
  int? userId;

  Address(
      {this.id,
      this.locationStr,
      this.latitude,
      this.longitude,
      this.buildingNo,
      this.floor,
      this.street,
      this.department,
      this.createdAt,
      this.deletedAt,
      this.updatedAt,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationStr = json['locationStr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    buildingNo = json['buildingNo'];
    floor = json['floor'];
    street = json['street'];
    department = json['department'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['locationStr'] = locationStr;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['buildingNo'] = buildingNo;
    data['floor'] = floor;
    data['street'] = street;
    data['department'] = department;
    data['createdAt'] = createdAt;
    data['deletedAt'] = deletedAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
