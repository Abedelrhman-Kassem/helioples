class PromoCodeModel {
  PromoCodeModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final PromoCodeData? data;
  final int? statusCode;
  final dynamic errors;

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : PromoCodeData.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class PromoCodeData {
  PromoCodeData({
    required this.amountBeforeDiscount,
    required this.amountAfterDiscount,
    required this.discount,
    required this.id,
    required this.code,
    required this.isPercentage,
  });

  final double? amountBeforeDiscount;
  final double? amountAfterDiscount;
  final double? discount;
  final String? id;
  final String? code;
  final bool? isPercentage;

  factory PromoCodeData.fromJson(Map<String, dynamic> json) {
    return PromoCodeData(
      id: json["id"],
      code: json["code"],
      amountBeforeDiscount: json["amountBeforeDiscount"].toDouble(),
      amountAfterDiscount: json["amountAfterDiscount"].toDouble(),
      discount: json["discount"].toDouble(),
      isPercentage: json["isPercentage"],
    );
  }
}
