class DeliveryTimeModel {
  DeliveryTimeModel({
    required this.success,
    required this.message,
    required this.availableTime,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<AvailableTime> availableTime;
  final int? statusCode;
  final dynamic errors;

  factory DeliveryTimeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTimeModel(
      success: json["success"],
      message: json["message"],
      availableTime: json["data"] == null
          ? []
          : List<AvailableTime>.from(
              json["data"]!.map((x) => AvailableTime.fromJson(x)),
            ),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class AvailableTime {
  AvailableTime({
    required this.id,
    required this.from,
    required this.to,
    required this.active,
    required this.maxCapacity,
  });

  final String? id;
  final DateTime? from;
  final DateTime? to;
  final bool? active;
  final int? maxCapacity;

  factory AvailableTime.fromJson(Map<String, dynamic> json) {
    return AvailableTime(
      id: json["id"],
      from: DateTime.tryParse(json["from"] ?? ""),
      to: DateTime.tryParse(json["to"] ?? ""),
      active: json["active"],
      maxCapacity: json["maxCapacity"],
    );
  }
}
