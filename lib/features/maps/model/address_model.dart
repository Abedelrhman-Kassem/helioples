class AddressModel {
  AddressModel({
    required this.success,
    required this.message,
    required this.address,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<Address> address;
  final int? statusCode;
  final dynamic errors;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      success: json["success"],
      message: json["message"],
      address: json["data"] == null
          ? []
          : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": address.map((x) => x.toJson()).toList(),
    "statusCode": statusCode,
    "errors": errors,
  };
}

class Address {
  Address({
    this.id,
    this.locationStr,
    this.latitude,
    this.longitude,
    this.buildingNo,
    this.floor,
    this.street,
    this.department,
    this.branchId,
    this.branchName,
    this.createdAt,
  });

  final String? id;
  String? locationStr;
  double? latitude;
  double? longitude;
  String? buildingNo;
  String? floor;
  String? street;
  String? department;
  final String? branchId;
  final dynamic branchName;
  final DateTime? createdAt;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      locationStr: json["locationStr"],
      latitude: (json["latitude"] as num?)?.toDouble(),
      longitude: (json["longitude"] as num?)?.toDouble(),
      buildingNo: json["buildingNo"],
      floor: json["floor"],
      street: json["street"],
      department: json["department"],
      branchId: json["branchId"],
      branchName: json["branchName"],

      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "locationStr": locationStr,
    if (latitude != null) "latitude": latitude,
    if (longitude != null) "longitude": longitude,
    "buildingNo": buildingNo,
    "floor": floor,
    "street": street,
    "department": department,
    if (branchId != null) "branchId": branchId,
    if (branchName != null) "branchName": branchName,
    if (createdAt != null) "createdAt": createdAt?.toIso8601String(),
  };
}
