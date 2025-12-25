class SpecialOfferModel {
  SpecialOfferModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final int? statusCode;
  final dynamic errors;

  factory SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return SpecialOfferModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class Data {
  Data({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  final List<Offer> items;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      page: json["page"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      totalPages: json["totalPages"],
      items: json["items"] == null
          ? []
          : List<Offer>.from(json["items"]!.map((x) => Offer.fromJson(x))),
    );
  }
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.thumbnailImage,
    required this.companyImage,
    required this.visits,
    required this.homeScreen,
    required this.active,
    required this.badge,
    required this.expiresAt,
    required this.pagedProducts,
  });

  final String? id;
  final String? name;
  final String? thumbnailImage;
  final String? companyImage;
  final int? visits;
  final bool? homeScreen;
  final bool? active;
  final String? badge;
  final DateTime? expiresAt;
  final dynamic pagedProducts;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["id"],
      name: json["name"],
      thumbnailImage: json["thumbnailImage"],
      companyImage: json["companyImage"],
      visits: json["visits"],
      homeScreen: json["homeScreen"],
      active: json["active"],
      badge: json["badge"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      pagedProducts: json["pagedProducts"],
    );
  }
}
