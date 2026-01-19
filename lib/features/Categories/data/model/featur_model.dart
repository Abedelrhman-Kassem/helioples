import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class FeaturMdel {
  FeaturMdel({
    required this.success,
    required this.message,
    required this.features,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<FeaturData> features;
  final int? statusCode;
  final dynamic errors;

  factory FeaturMdel.fromJson(Map<String, dynamic> json) {
    return FeaturMdel(
      success: json["success"],
      message: json["message"],
      features: json["data"] == null
          ? []
          : List<FeaturData>.from(
              json["data"]!.map((x) => FeaturData.fromJson(x)),
            ),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class FeaturData {
  FeaturData({
    required this.id,
    required this.name,
    required this.description,
    required this.iconImage,
    required this.bannerImage,
    required this.categoryId,
    required this.categoryName,
    required this.active,
    required this.products,
    required this.pagedProducts,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? iconImage;
  final String? bannerImage;
  final String? categoryId;
  final String? categoryName;
  final bool? active;
  final List<Products> products;
  final dynamic pagedProducts;

  factory FeaturData.fromJson(Map<String, dynamic> json) {
    return FeaturData(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      iconImage: json["iconImage"],
      bannerImage: json["bannerImage"],
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      active: json["active"],
      products: json["products"] == null
          ? []
          : List<Products>.from(
              json["products"]!.map((x) => Products.fromJson(x)),
            ),
      pagedProducts: json["pagedProducts"],
    );
  }
}
