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
      from: _parseTime(json["from"]),
      to: _parseTime(json["to"]),
      active: json["active"],
      maxCapacity: json["maxCapacity"],
    );
  }

  /// Parses time string in format "HH:mm:ss" to DateTime
  static DateTime? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final second = parts.length >= 3 ? int.parse(parts[2]) : 0;
        // Use a fixed date, only time matters
        return DateTime(2000, 1, 1, hour, minute, second);
      }
    } catch (_) {}
    return null;
  }
}
